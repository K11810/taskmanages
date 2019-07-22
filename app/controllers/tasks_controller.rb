class TasksController < ApplicationController
before_action :set_task, only: [:show, :edit, :update, :destroy]

PER = 9

  def new
    if params[:back]
      @task = Task.new(task_params)
    else
      @task = Task.new
    end
  end

  def create
    @task = current_user.tasks.build(task_params)
			if @task.save
				redirect_to tasks_path, notice: "タスクを作成しました！"
			else
				render 'new'
			end
  end

  def index
    if params[:sort_expired].present?
      @tasks = Task.all.sort_deadline.page(params[:page]).per(PER)
    elsif params[:sort_priority].present?
      @tasks = Task.all.sort_priority.page(params[:page]).per(PER)
    elsif params[:title] && params[:status]
      @tasks = Task.search_title(params[:title]).search_status(params[:status]).page(params[:page]).per(PER)
    elsif params[:status]
      @tasks = Task.search_status(params[:status]).page(params[:page]).per(PER)
    elsif params[:title]
      @tasks = Task.search_title(params[:title]).page(params[:page]).per(PER)
    else
      @tasks = Task.page(params[:page]).per(PER)
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
    @task = current_user.tasks.new(task_params)
    render :new unless @task.valid?
  end

  private
  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :content, :deadline, :status, :priority)
  end

end
