class Admin::UsersController < ApplicationController
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
    @user.destroy
    redirect_to admin_users_path, notice:"ユーザー「#{@user.name}」を削除しました"
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
    params.require(:user).permit(:name,:email,:password,:password_confirmation)
  end

end
