class GenerationsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy, :my_generations]
  before_action :set_generation, only: [:show, :destroy, :question_cards, :answers]
  before_action :auth, only: [:destroy]

  # GET /generations
  # GET /generations.json
  def index
    @generations = Generation.all
  end

  def my_generations
    @generations = current_user.generations.sort { |a, b| b.updated_at <=> a.updated_at }
    respond_to do |format|
      format.html
      format.json do
        render json: @generations
      end
    end
  end

  # GET /generations/1
  # GET /generations/1.json
  def show
  end

  # GET /generations/1/question_cards
  # GET /generations/1/question_cards.pdf
  def question_cards
    template = @generation.question_card.question_card
    @cards = @generation.variants.map do |v|
      card = template.gsub('$V', v.number.to_s)

      doc = Nokogiri::HTML(card)
      doc.css('.task').each do |task|
        task.inner_html = generate_task_text( v.generated_tasks.find_by(task_in_card: task[:id].to_i) )
      end
      doc.to_html
    end

    respond_to do |format|
      format.html { render layout: false }
      format.pdf do
        orientation = params[:orientation] ? 'Portrait' : 'Landscape'
        render pdf: "question_card",   # Excluding ".pdf" extension.
          orientation: orientation
      end
    end
  end

  # GET /generations/1/answers
  # GET /generations/1/answers.pdf
  def answers
    card = @generation.question_card.question_card
    @answers = @generation.variants.map do |v|
      tasks = Nokogiri::HTML(card).css('.task').map do |task|
        gen_task = v.generated_tasks.find_by(task_in_card: task[:id].to_i)
        task_text = generate_task_text( gen_task )
        t = gen_task.task

        generated_variables = gen_task.generated_variables.map { |var| [var.variable.name, var.value] }.to_h

        t.calculated_variables.each do |var|
          res = calculate(var.formula, generated_variables)
          generated_variables[var.name] = res
        end
        answer = paste_variables(t.answer, generated_variables)

        return {
            name: task[:task_name],
            task: t,
            task_text: task_text,
            answer: answer
        }
      end
      return {
          variant: v.number,
          tasks_in_card: tasks
      }
    end

    respond_to do |format|
      format.html { render layout: false }
      format.pdf do
        orientation = params[:orientation] ? 'Portrait' : 'Landscape'
        render pdf: "answers",   # Excluding ".pdf" extension.
          orientation: orientation
      end
    end
  end

  # POST /generations
  # POST /generations.json
  def create
    @generation = Generation.new(generation_params)
    @generation.user = current_user

    @generation.transaction do
      @generation.save!
      tasks_in_card = Nokogiri::HTML(@generation.question_card.question_card).css('.task')
      params.require(:number_variants).to_i.times do |i|
        variant = Variant.create!(number: i + 1, generation: @generation)
        tasks_in_card.each do |task|
          task_id = task[:task_id].to_i
          if task_id == 0
            tasks = TasksGroup.find(task[:tasks_group_id].to_i).tasks.ids
            generated_tasks = @generation.question_card.generated_tasks.map { |t| t.task.id }
            tasks -= generated_tasks if tasks.count > generated_tasks.count
            task_id = tasks.shuffle.first
          end
          generated_task = GeneratedTask.create!(variant: variant, task_in_card: task[:id].to_i, task_id: task_id)

          generated_task.task.variables.each do |v|
            rnd = Random.new
            res = rnd.rand(v.from .. v.to)
            res = res.round(v.round) unless v.round.nil?
            GeneratedVariable.create!(generated_task: generated_task, variable: v, value: res)
          end
        end
      end
    end

    respond_to do |format|
      if !@generation.errors.any?
        format.html { redirect_to @generation, notice: 'Generation was successfully created.' }
        format.json { render :show, status: :created, location: @generation }
      else
        format.html { render :new }
        format.json { render json: @generation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /generations/1
  # DELETE /generations/1.json
  def destroy
    @generation.destroy
    respond_to do |format|
      format.html { redirect_to generations_my_url, notice: 'Сгенерированные варианты были успешно удалены.' }
      format.json { head :no_content }
    end
  end

  def paste_variables(text, variables)
    variables.keys.sort { |a, b| b <=> a }.each { |name| text.gsub!('$' + name, variables[name].to_s) }
    text
  end

  def generate_task_text(generated_task)
    variables = generated_task.generated_variables.map { |v| [v.variable.name, v.value] }.to_h
    paste_variables(generated_task.task.task, variables)
  end

  def calculate(ex, generated_variables)
    ex = paste_variables(ex, generated_variables)
    Rails.cache.fetch("#{Rails.configuration.cache_answer_key}/#{ex}", expires_in: 12.hours) do
      options = { "format" => "plaintext" }
      client = WolframAlpha::Client.new Rails.configuration.wolfram_api, options
      response = client.query ex + '+0'
      result = response.find { |pod| pod.title == "Result" }
      result.subpods[0].plaintext
    end
  end

  def auth
    unless current_user == @generation.user
      redirect_to '/', alert: 'У Вас нет прав.'
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_generation
    @generation = Generation.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def generation_params
    params.permit(:question_card_id, :title)
  end
end
