class TasksController < ApplicationController
  before_filter :authenticate_user!, only: [:new, :show, :edit, :destroy]
  before_action :set_task, only: [:show, :edit, :destroy]

  # GET /tasks
  # GET /tasks.json
  def index
    @tasks = Task.all
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
    2.times { @task.variables.build}
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  # POST /tasks.json
  def create
    task = task_params
    task[:date] = Time.now
    task[:user] = current_user.id
    @task = Task.new(task)
    variables = params.require(:task).permit(:variables).reject{ |variable|
      variable[:name] || variable[:type] || variable[:from] == '' || variable[:to] == ''
    }

    respond_to do |format|
      if @task.save && variables.all?{ |variable| Variable.new(variable).save }
        format.html { redirect_to @task, notice: 'Task was successfully created.' }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  # def update
  #   respond_to do |format|
  #     if @task.update(task_params)
  #       format.html { redirect_to @task, notice: 'Task was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @task }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @task.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    respond_to do |format|
      if @task.update(removed: true)
        format.html { redirect_to tasks_url, notice: 'Task was successfully destroyed.' }
        format.json { head :no_content }
      else
        format.html { render :show }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
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
      params.require(:task).permit(:title, :description, :task, :answer, :subject)
    end
end
