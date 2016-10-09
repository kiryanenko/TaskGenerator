require 'test_helper'

class MainPageControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get main_page_index_url
    assert_response :success
  end

  test "should get welcome" do
    get main_page_welcome_url
    assert_response :success
  end

end
