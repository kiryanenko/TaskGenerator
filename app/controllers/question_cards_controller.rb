class QuestionCardsController < ApplicationController
  before_action :set_question_card, only: [:show, :edit, :update, :destroy, :generate]

  require 'nokogiri'

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
    @question_card.user = current_user

    doc = Nokogiri::HTML(@question_card.question_card)
    doc.css('.task').each_with_index { |task, i| task['id'] = i.to_s }
    @question_card.question_card = doc.to_html

    respond_to do |format|
      if @question_card.save
        format.html { redirect_to @question_card, notice: 'Билет успешно создан.' }
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
    @question_card = @question_card.do_before_update
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
    @question_card.remove
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
      params.require(:question_card).permit(:subject, :title, :description, :question_card)
    end
end
