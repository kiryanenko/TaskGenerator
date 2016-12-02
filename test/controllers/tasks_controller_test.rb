require 'test_helper'

class TasksControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:one)
    sign_in @user
    @task = tasks(:one)
  end

  test "should get index" do
    get tasks_url
    assert_response :success
  end

  test "should get my" do
    get tasks_my_url
    assert_response :success
  end

  test "should get new" do
    get new_task_url
    assert_response :success
  end

  test "should create task" do
    assert_difference('Task.count') do
      post tasks_url, params: { task: { answer: @task.answer, description: @task.description, subject: @task.subject,
                                        task: @task.task, title: @task.title } }
    end
    assert_redirected_to task_url(Task.last)
  end

  test "should create copy to my" do
    assert_difference('Task.count') do
      get task_url(@task) + '/add_to_me'
    end
    task = Task.last
    assert_equal task.user, @user
    assert_redirected_to task_url(task)
  end

  test "should show task" do
    get task_url(@task)
    assert_response :success
  end

  test "should get edit" do
    get edit_task_url(@task)
    assert_response :success
  end

  test "should update task" do
    patch task_url(@task), params: { task: { answer: @task.answer, description: @task.description,
                                             subject: @task.subject, task: @task.task,
                                             title: @task.title } }
    assert_redirected_to task_url(@task)
  end

  test "should destroy task" do
    assert_difference('Task.count', -1) do
      delete task_url(@task)
    end

    assert_redirected_to tasks_url
  end
end
