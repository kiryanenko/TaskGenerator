class TasksController < ApplicationController
  before_filter :authenticate_user!, only: [:new, :show, :edit, :destroy]
  before_action :set_task, only: [:show, :edit, :destroy, :update]

  # GET /tasks
  # GET /tasks.json
  def index
    @tasks = Task.all
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
  end

  # GET /tasks/my_tasks
  # GET /tasks/my
  def my_tasks
    @tasks = current_user.tasks.where(removed: false)
    respond_to do |format|
      format.html
      format.json do
        render json: {type: @tasks.class.to_s, value: @tasks}
      end
    end
  end

  # GET /tasks/new
  def new
    @task = Task.new
    2.times { @task.variables.build }
    1.times { @task.calculated_variables.build }
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(task_params)
    @task.user = current_user

    respond_to do |format|
      if @task.save
        format.html { redirect_to @task, notice: 'Задача успешно создана!' }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    @task = @task.do_before_update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: 'Task was successfully updated.' }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.remove
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: 'Задача была успешно удалена' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
      @variables = Variable.where(task: @task.id)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(
          :title, :description, :task, :answer, :subject,
          variables_attributes: [:id, :name, :from, :to],
          calculated_variables_attributes: [:id, :name, :formula]
      )
    end
end
