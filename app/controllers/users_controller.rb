class UsersController < ApplicationController 
  before_action :only_loggedin_users, except: [:new, :create]
  before_action :correct_user, only: [:edit, :update]

  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_url
    else
      render 'new'
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end

  def show
    @user = User.find(params[:id])
  end

  def index
    @users = User.paginate(page: params[:page], per_page: 10)
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Saved successfully!"
      redirect_to root_url
    else
      flash[:danger] = "Invaild. Try again."
      render 'edit'
    end
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
    
    def correct_user
      @user = User.find(params[:id])
      if @user != current_user
        flash[:danger] = "You are not authorized"
        redirect_to root_url
      end
    end

end