require 'test_helper'

class MainPageControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:one)
  end

  test "should get index" do
    get main_page_index_url
    assert_response :success
  end

  test "should get welcome" do
    get main_page_welcome_url
    assert_response :success
  end

  test "should get help" do
    get main_page_help_url
    assert_response :success
  end

end
