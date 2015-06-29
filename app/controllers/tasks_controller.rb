class TasksController < ApplicationController
  def new
    @list = List.find(params[:list_id])
    @task = @list.tasks.new
  end

  def show
    @list = List.find(params[:list_id])
    @task = Task.find(params[:id])
    redirect_to list_path(@task.list)
  end

  def create
    @list = List.find(params[:list_id])
    @task = @list.tasks.new(task_params)
    if @task.save
      flash.notice = "Task Successfully Added! BRUH!"
      redirect_to list_path(@task.list)
    else
      render :new
    end
  end

  # def update
  #   @list = List.find(params[:list_id])
  #   @task = @list.tasks.find(params[:id])
  #   @task.update(done: true)
  #   redirect_to list_path(@list)
  # end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      redirect_to list_task_path
    else
      render :edit
    end
  end

  def destroy
    @list = List.find(params[:list_id])
    @task = @list.tasks.find(params[:id])
    @task.destroy
    redirect_to list_path(@list)
  end

  def edit
    @list = List.find(params[:list_id])
    @task = @list.tasks.find(params[:id])
    render :edit
  end

private
  def task_params
    params.require(:task).permit(:done, :description)
  end
end
