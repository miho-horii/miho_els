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
    @users = User.paginate(page: params[:page], per_page: 10).order(created_at: :desc)
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

  def following
    @title ="Following"
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page], per_page: 5)
    @all_users = @user.followed_users
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page], per_page: 5)
    @all_users = @user.followers
    render 'show_follow'
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