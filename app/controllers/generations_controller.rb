class GenerationsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_generation, only: [:show, :destroy, :question_cards, :answers]

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
      format.html
      format.pdf do
        render pdf: "question_card"   # Excluding ".pdf" extension.

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

        answer = t.answer
        generated_variables = gen_task.generated_variables.map { |var| [var.variable.name, var.value] }.to_h
        t.calculated_variables.each do |var|
          res = calculate(var.formula, generated_variables).to_f
          generated_variables[var.name] = res
          answer.gsub!('$' + var.name, res)
        end

        {
            name: task[:task_name],
            task: t,
            task_text: task_text,
            answer: answer
        }
      end
      {
          variant: v.number,
          tasks_in_card: tasks
      }
    end

    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "answers"   # Excluding ".pdf" extension.

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

          generated_variables = {}
          generated_task.task.variables.each do |v|
            from = calculate(v.from, generated_variables).to_f
            to = calculate(v.to, generated_variables).to_f
            rnd = Random.new
            res = rnd.rand(from..to)
            generated_variables[v.name] = res
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
      format.html { redirect_to generations_url, notice: 'Generation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def generate_task_text(generated_task)
    task_text = generated_task.task.task
    generated_task.generated_variables.each do |variable|
      task_text.gsub!('$' + variable.variable.name, variable.value)
    end
    return task_text
  end

  def calculate(ex, generated_variables)
    generated_variables.each { |v, res| ex.gsub!('$' + v, res) }

    options = { "format" => "plaintext" }
    client = WolframAlpha::Client.new "UUHYPG-WUPR2YEXLQ", options
    response = client.query ex
    result = response.find { |pod| pod.title == "Result" }
    return result.subpods[0].plaintext
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
