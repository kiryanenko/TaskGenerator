require 'test_helper'

class QuestionCardsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:one)
    @question_card = question_cards(:one)
    @question_card_update = question_cards(:for_update)
  end

  test "should get index" do
    get question_cards_url
    assert_response :success
  end

  test "should get new" do
    get new_question_card_url
    assert_response :success
  end

  test "should create question_card" do
    assert_difference('QuestionCard.count') do
      post question_cards_url, params: { question_card: { description: @question_card.description,
                                                          question_card: @question_card.question_card,
                                                          subject: @question_card.subject,
                                                          title: @question_card.title} }
    end

    assert_redirected_to question_card_url(QuestionCard.last)
  end

  test "should show question_card" do
    get question_card_url(@question_card)
    assert_response :success
  end

  test "should get edit" do
    get edit_question_card_url(@question_card)
    assert_response :success
  end

  test "should update question_card" do
    patch question_card_url(@question_card_update), params: {
        question_card: {
            description: @question_card_update.description, question_card: @question_card_update.question_card,
            subject: @question_card_update.subject, title: @question_card_update.title
        }
    }
    assert_redirected_to question_card_url(@question_card_update)
  end

  test "should destroy question_card" do
    assert_difference('QuestionCard.count', -1) do
      delete question_card_url(question_cards(:for_destroy))
    end

    assert_redirected_to question_cards_url
  end
end
