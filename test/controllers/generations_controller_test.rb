require 'test_helper'

class GenerationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @generation = generations(:one)
  end

  test "should get index" do
    get generations_url
    assert_response :success
  end

  test "should get new" do
    get new_generation_url
    assert_response :success
  end

  test "should create generation" do
    assert_difference('Generation.count') do
      post generations_url, params: { generation: { page_layout_id: @generation.page_layout_id, question_card_id: @generation.question_card_id, user_id: @generation.user_id } }
    end

    assert_redirected_to generation_url(Generation.last)
  end

  test "should show generation" do
    get generation_url(@generation)
    assert_response :success
  end

  test "should get edit" do
    get edit_generation_url(@generation)
    assert_response :success
  end

  test "should update generation" do
    patch generation_url(@generation), params: { generation: { page_layout_id: @generation.page_layout_id, question_card_id: @generation.question_card_id, user_id: @generation.user_id } }
    assert_redirected_to generation_url(@generation)
  end

  test "should destroy generation" do
    assert_difference('Generation.count', -1) do
      delete generation_url(@generation)
    end

    assert_redirected_to generations_url
  end
end
