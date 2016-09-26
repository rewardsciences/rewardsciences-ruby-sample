class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      identify_reward_sciences_user(user)
      redirect_to(root_path, notice: 'Signed in')
    else
      redirect_to(login_path, notice: 'Invalid email or password')
    end
  end

  def destroy
    reset_session
    redirect_to(login_path, notice: 'Signed out')
  end
end
