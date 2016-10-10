class QuestionCardsController < ApplicationController
  before_action :set_question_card, only: [:show, :edit, :update, :destroy]

  # GET /question_cards
  # GET /question_cards.json
  def index
    @question_cards = QuestionCard.all
  end

  # GET /question_cards/1
  # GET /question_cards/1.json
  def show
  end

  # GET /question_cards/new
  def new
    @question_card = QuestionCard.new
  end

  # GET /question_cards/1/edit
  def edit
  end

  # POST /question_cards
  # POST /question_cards.json
  def create
    @question_card = QuestionCard.new(question_card_params)

    respond_to do |format|
      if @question_card.save
        format.html { redirect_to @question_card, notice: 'Question card was successfully created.' }
        format.json { render :show, status: :created, location: @question_card }
      else
        format.html { render :new }
        format.json { render json: @question_card.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /question_cards/1
  # PATCH/PUT /question_cards/1.json
  def update
    respond_to do |format|
      if @question_card.update(question_card_params)
        format.html { redirect_to @question_card, notice: 'Question card was successfully updated.' }
        format.json { render :show, status: :ok, location: @question_card }
      else
        format.html { render :edit }
        format.json { render json: @question_card.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /question_cards/1
  # DELETE /question_cards/1.json
  def destroy
    @question_card.destroy
    respond_to do |format|
      format.html { redirect_to question_cards_url, notice: 'Question card was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question_card
      @question_card = QuestionCard.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_card_params
      params.require(:question_card).permit(:user, :subject, :title, :description, :question_card, :date, :removed)
    end
end
