class UsersController < ApplicationController
  before_action :authenticate_user, only: [:show]
  before_action :forbid_login_user, only: [:new,:create]
  before_action :ensure_correct_user, only: [:show]

  def new
   @user = User.new
  end

  def create
   @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user.id), notice: 'ユーザー登録が完了しました'
     else
      render 'new'
    end
  end

  def show
    if current_user == User.find(params[:id])
      @user = User.find(params[:id])
    else
      redirect_to(tasks_path, danger:"ユーザーが異なります。ログインし直してください")
    end
  end

  private

  def user_params
   params.require(:user).permit(:name, :email, :password,
                               :password_confirmation)
  end

  def ensure_correct_user
    if current_user.id != params[:id].to_i
      redirect_to user_path(current_user.id), notice: "権限がありません"
    end
  end

end
