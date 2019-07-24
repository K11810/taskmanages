class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  def authenticate_user
      redirect_to new_session_path, notice: 'ログインしてください' unless current_user
  end

  def forbid_login_user
    if current_user
      redirect_to user_path(current_user.id), notice: "すでにログイン中です"
    end
  end

end
