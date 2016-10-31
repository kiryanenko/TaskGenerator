class GenerationsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_generation, only: [:show, :destroy, :question_card]

  # GET /generations
  # GET /generations.json
  def index
    @generations = Generation.all
  end

  # GET /generations/1
  # GET /generations/1.json
  def show
    @question_card = QuestionCard.find(@generation.question_card_id)
  end

  # GET /generations/1/question_card
  # GET /generations/1/question_card.pdf
  def question_card
    @card = QuestionCard.find(@generation.question_card_id).question_card

    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "question_card"   # Excluding ".pdf" extension.

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
    gen_params = params.permit(:question_card_id, :page_layout_id)
    gen_params[:orientation] = !params.require(:number_variants).nil?
    gen_params[:user_id] = current_user.id
    @generation = Generation.new(gen_params)

    respond_to do |format|
      if @generation.save
        tasksInCard = TaskInCard.where(card: gen_params[:question_card_id])
        params.require(:number_variants).to_i.times do |i|
          variant = Variant.new(number: i + 1, generation: @generation.id)
          variant.save
          tasksInCard.each do |task|
            p variant
            p task
            GeneratedTask.new(variant: variant.id, task: task.id).save
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
    # def generation_params
    #   params.permit(:question_card_id, :page_layout_id, :number_variants)
    # end
end
