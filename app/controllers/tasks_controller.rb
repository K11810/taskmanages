class TasksController < ApplicationController
  before_action :authenticate_user
  before_action :ensure_correct_user_to_task, only: [:show, :edit, :update, :destroy]
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
				redirect_to tasks_path, notice: "タスク「#{@task.title}」を作成しました"
			else
				render 'new'
			end
  end

  def index
    if params[:sort_expired].present?
      @tasks = current_user.tasks.all.sort_deadline.page(params[:page]).per(PER)
    elsif params[:sort_priority].present?
      @tasks = current_user.tasks.all.sort_priority.page(params[:page]).per(PER)
    elsif params[:title] && params[:status]
      @tasks = current_user.tasks.search_title(params[:title]).search_status(params[:status]).page(params[:page]).per(PER)
    elsif params[:status]
      @tasks = current_user.tasks.search_status(params[:status]).page(params[:page]).per(PER)
    elsif params[:title]
      @tasks = current_user.tasks.search_title(params[:title]).page(params[:page]).per(PER)
    else
      @tasks = current_user.tasks.page(params[:page]).per(PER)
    end
  end

  def show
  end

  def edit
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice:"タスク「#{@task.title}」を削除しました"
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: "タスク「#{@task.title}」を編集しました！"
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
    @task = current_user.tasks.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :content, :deadline, :status, :priority)
  end

  def ensure_correct_user_to_task
    @task = Task.find(params[:id])
    if current_user.id != @task.user_id
      redirect_to tasks_path, notice: "権限がありません."
    end
  end

end
