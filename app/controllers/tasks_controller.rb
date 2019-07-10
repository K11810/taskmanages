class TasksController < ApplicationController
before_action :set_task, only: [:show, :edit, :update, :destroy]

  def new
    if params[:back]
      @task = Task.new(task_params)
    else
      @task = Task.new
    end
  end

  def create
    @task = Task.new(task_params)
			if @task.save
				redirect_to tasks_path, notice: "タスクを作成しました！"
			else
				render 'new'
			end
  end

  def index
    if params[:sort_expired].present?
      @tasks = Task.all.order(deadline: "desc")
    elsif params[:title] && params[:status]
      @tasks = Task.where('title LIKE ? and status LIKE ?' , "%#{params[:title]}%","%#{params[:status]}%")
    elsif params[:status]
      @tasks = Task.where(title: params[:title])
    elsif params[:title]
      @tasks = Task.where(status: params[:status][:name])
    else
      @tasks = Task.all.order(created_at: "desc")
    end
  end

  def show
  end

  def edit
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice:"タスクを削除しました"
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: "タスクを編集しました！"
    else
      render 'edit'
    end
  end

  def confirm
    @task = Task.new(task_params)
    render :new if @task.invalid?
  end

  private

    def set_task
      @task = Task.find(params[:id])
    end

    def task_params
	    params.require(:task).permit(:title, :content, :deadline, :status)
	  end

end
