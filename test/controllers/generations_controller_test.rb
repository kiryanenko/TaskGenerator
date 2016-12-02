require 'test_helper'

class GenerationsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:one)
    @generation = generations(:one)
  end

  test "should get index" do
    get generations_url
    assert_response :success
  end

  test "should get history of generations" do
    get generations_my_url
    assert_response :success
  end

  test "should show question cards" do
    get generation_url(@generation) + '/question_cards', params: {page_layout: 0}
    assert_response :success
  end

  test "should show answers" do
    get generation_url(@generation) + '/answers', params: {page_layout: 0}
    assert_response :success
  end

  test "should create generation" do
    assert_difference('Generation.count') do
      post generations_url, params: { question_card_id: @generation.question_card_id,
                                      title: @generation.title, number_variants: 1 }
    end
    assert_redirected_to generation_url(Generation.last)
  end

  test "should show generation" do
    get generation_url(@generation)
    assert_response :success
  end

  test "should destroy generation" do
    assert_difference('Generation.count', -1) do
      delete generation_url(@generation)
    end

    assert_redirected_to generations_my_url
  end
end
