require 'test_helper'

class TasksGroupsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:one)
    @tasks_group = tasks_groups(:one)
  end

  test "should get index" do
    get tasks_groups_url
    assert_response :success
  end

  test "should get new" do
    get new_tasks_group_url
    assert_response :success
  end

  test "should create tasks_group" do
    assert_difference('TasksGroup.count') do
      post tasks_groups_url, params: { tasks_group: { description: @tasks_group.description,
                                                      subject: @tasks_group.subject,
                                                      title: @tasks_group.title } }
    end

    assert_redirected_to tasks_group_url(TasksGroup.last)
  end

  test "should show tasks_group" do
    get tasks_group_url(@tasks_group)
    assert_response :success
  end

  test "should get edit" do
    p @tasks_group
    get edit_tasks_group_url(@tasks_group)
    assert_response :success
  end

  test "should update tasks_group" do
    patch tasks_group_url(@tasks_group), params: { tasks_group: { description: @tasks_group.description,
                                                                  subject: @tasks_group.subject,
                                                                  title: @tasks_group.title } }
    assert_redirected_to tasks_group_url(@tasks_group)
  end

  test "should destroy tasks_group" do
    assert_difference('TasksGroup.count', -1) do
      delete tasks_group_url(@tasks_group)
    end

    assert_redirected_to tasks_groups_url
  end
end
