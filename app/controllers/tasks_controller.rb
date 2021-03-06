class TasksController < ApplicationController
  before_action :logged_in_user
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  respond_to :html, :json
  # GET /tasks
  # GET /tasks.json
  def index
    params.delete_if{|k,v| v=='' || v=='0' }

    if params[:cat_id]
      @tasks = Task.where(cat_id: params[:cat_id])
    else
      @tasks = Task.all
    end
    store_path(@tasks)
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
    @title = 'Редактирование задачи'
    respond_modal_with @task, location: root_path
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to @task, notice: 'Task was successfully created.' }
        format.json { render :root_path, status: :created, location: @task }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to last_page_url(Task), notice: 'Task was successfully updated.' }
        format.json { render :root_path, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:name, :date, :personal, :cat_id, :done,:description)
    end
end
