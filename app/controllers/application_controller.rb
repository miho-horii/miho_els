class ApplicationController < ActionController::Base
  include SessionsHelper

  def only_loggedin_users
    unless logged_in?
      flash[:info] = "Please login first."
      redirect_to login_url 
    end
  end
  
end
