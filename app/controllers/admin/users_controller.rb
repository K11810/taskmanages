class Admin::UsersController < ApplicationController
  before_action :forbid_before_login
  before_action :forbid_general_users
  before_action :prohibited_admin_destroy, only: [:destroy]
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  PER = 10

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
      if @user.save
        redirect_to admin_users_path(@user.id), notice: "ユーザー「#{@user.name}」を登録しました"
      else
        render "admin/users/new"
      end
  end

  def edit
  end

  def show
  end

  def index
    @users=User.all.includes(:tasks)
    @users= @users.order(id: :asc).page(params[:page]).per(PER)
  end

  def destroy
    if User.where(admin: true).count > 1
      @user.destroy
      redirect_to admin_users_path, notice:"ユーザー「#{@user.name}」を削除しました"
    else
      flash[:notice] = "管理者ユーザが存在しなくなるため「#{@user.name}」を削除出来ません。"
      redirect_to admin_users_path
    end
  end

  def update
    if @user.update(user_params)
      redirect_to admin_users_path, notice: "ユーザー「#{@user.name}」を編集しました！"
    else
      render 'admin/edit'
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name,:email,:password,:password_confirmation, :admin)
  end

  def forbid_before_login
    unless current_user
      redirect_to new_session_path , notice: "権限がありません"
    end
  end

  def forbid_general_users
    unless current_user.admin?
     redirect_to root_path , notice: "権限がありません"
    end
  end

  def prohibited_admin_destroy
    if current_user.admin? && current_user === @user
      redirect_to admin_users_path , notice: "管理者の削除はできません"
    end
  end

end
