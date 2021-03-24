class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      flash[:success] = "Logged in successfully"
      log_in user
      redirect_to root_url
    else
      render 'new'
      flash[:danger] = "Invalid E-mail or password. Please try again."
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
