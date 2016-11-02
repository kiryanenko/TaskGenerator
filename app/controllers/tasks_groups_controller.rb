class TasksGroupsController < ApplicationController
  before_action :set_tasks_group, only: [:show, :edit, :update, :destroy]

  # GET /tasks_groups
  # GET /tasks_groups.json
  def index
    @tasks_groups = TasksGroup.all
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
    group = tasks_group_params
    group[:user] = current_user.id
    @tasks_group = TasksGroup.new(group)

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

  # DELETE /tasks_groups/1
  # DELETE /tasks_groups/1.json
  def destroy
    @tasks_group.destroy
    respond_to do |format|
      format.html { redirect_to tasks_groups_url, notice: 'Tasks group was successfully destroyed.' }
      format.json { head :no_content }
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
