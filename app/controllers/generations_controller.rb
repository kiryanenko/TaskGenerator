class GenerationsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_generation, only: [:show, :destroy, :question_cards, :answers]

  # GET /generations
  # GET /generations.json
  def index
    @generations = Generation.all
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
        task.inner_html = v.generated_tasks.find_by(task_in_card: task[:id].to_i).task.task
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
        {
            name: task[:task_name],
            task: v.generated_tasks.find_by(task_in_card: task[:id].to_i).task
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

  # GET /generations/new
  # def new
  #   @generation = Generation.new
  # end

  # GET /generations/1/edit
  # def edit
  # end

  # POST /generations
  # POST /generations.json
  def create
    @generation = Generation.new(generation_params)
    @generation.user = current_user

    respond_to do |format|
      if @generation.save
        tasks_in_card = Nokogiri::HTML(@generation.question_card.question_card).css('.task')
        params.require(:number_variants).to_i.times do |i|
          variant = Variant.new(number: i + 1, generation: @generation)
          variant.save
          tasks_in_card.each do |task|
            task_id = task[:task_id].to_i
            if task_id == 0
              tasks = TasksGroup.find(task[:tasks_group_id].to_i).tasks.ids
              generated_tasks = @generation.question_card.generated_tasks.map { |t| t.task.id }
              tasks -= generated_tasks if tasks.count > generated_tasks.count
              task_id = tasks.shuffle.first
            end
            GeneratedTask.new(variant: variant, task_in_card: task[:id].to_i, task_id: task_id).save
          end
        end

        format.html { redirect_to @generation, notice: 'Generation was successfully created.' }
        format.json { render :show, status: :created, location: @generation }
      else
        format.html { render :new }
        format.json { render json: @generation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /generations/1
  # PATCH/PUT /generations/1.json
  # def update
  #   respond_to do |format|
  #     if @generation.update(generation_params)
  #       format.html { redirect_to @generation, notice: 'Generation was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @generation }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @generation.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /generations/1
  # DELETE /generations/1.json
  def destroy
    @generation.destroy
    respond_to do |format|
      format.html { redirect_to generations_url, notice: 'Generation was successfully destroyed.' }
      format.json { head :no_content }
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
