class TasksGroupsController < ApplicationController
  before_filter :authenticate_user!, only: [:new, :edit, :destroy, :my_groups, :create, :update, :remove_task, :add_task]
  before_action :set_tasks_group, only: [:show, :edit, :update, :destroy, :add_task, :remove_task]
  before_action :auth, only: [:edit, :update, :destroy, :add_task, :remove_task]

  # GET /tasks_groups
  # GET /tasks_groups.json
  def index
    @tasks_groups = TasksGroup.all
  end

  # GET /tasks_groups/my_groups.json
  def my_groups
    @tasks_groups = current_user.tasks_groups.where(removed: false)
    respond_to do |format|
      format.html
      format.json do
        render json: {type: @tasks_groups.class.to_s, value: @tasks_groups}
      end
    end
  end

  # GET /tasks_groups/1
  # GET /tasks_groups/1.json
  def show
  end

  # GET /tasks_groups/new
  def new
    @tasks_group = TasksGroup.new
  end

  # GET /tasks_groups/1/edit
  def edit
  end

  # POST /tasks_groups
  # POST /tasks_groups.json
  def create
    @tasks_group = TasksGroup.new(tasks_group_params)
    @tasks_group.user = current_user

    respond_to do |format|
      if @tasks_group.save
        format.html { redirect_to @tasks_group, notice: 'Tasks group was successfully created.' }
        format.json { render :show, status: :created, location: @tasks_group }
      else
        format.html { render :new }
        format.json { render json: @tasks_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks_groups/1
  # PATCH/PUT /tasks_groups/1.json
  def update
    @tasks_group = @tasks_group.do_before_update
    respond_to do |format|
      if @tasks_group.update(tasks_group_params)
        format.html { redirect_to @tasks_group, notice: 'Tasks group was successfully updated.' }
        format.json { render :show, status: :ok, location: @tasks_group }
      else
        format.html { render :edit }
        format.json { render json: @tasks_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tasks_groups/1/add_task.json
  def add_task
    @tasks_group.tasks << Task.find( params.require(:task_id) )
    respond_to do |format|
      if !@tasks_group.errors.any?
        format.json { render json: {notice: "Задача успешно добавлена в группу: #{@tasks_group.title}"}, status: :ok }
      else
        format.json { render json: @tasks_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks_groups/1/remove_task.json
  def remove_task
    @tasks_group.tasks.delete( params.require(:task_id) )
    respond_to do |format|
      format.json { render json: {notice: "Задача успешно удалена из группы: #{@tasks_group.title}"}, status: :ok }
    end
  end

  # DELETE /tasks_groups/1
  # DELETE /tasks_groups/1.json
  def destroy
    @tasks_group.remove
    respond_to do |format|
      format.html { redirect_to tasks_groups_url, notice: 'Tasks group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def auth
    unless current_user == @tasks_group.user
      redirect_to '/', alert: 'У Вас нет прав.'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tasks_group
      @tasks_group = TasksGroup.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tasks_group_params
      params.require(:tasks_group).permit(:user, :subject, :title, :description, :date, :removed)
    end
end
