class UsersController < ApplicationController

  before_action :require_signin, except: [:new, :create]
  before_action :require_correct_user, only: [:edit, :update]
  before_action :require_admin, only: [:destroy]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @reviews = @user.reviews
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to @user, message: "Thanks for signing up!"
    else
      render :new
    end
  end

  def edit
    # It is a duplicate line because require_correct_user method creates @user for these methods.
    #@user = User.find(params[:id])
  end

  def update
    #@user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to @user, notice: "Account updated"
    else
      render :edit
    end
  end

  def destroy
    #@user = User.find(params[:id])  If user can delete themselves, this line goes away.  :destroy up to current_user.
    @user = User.find(params[:id])
    @user.destroy
    #session[:user_id] = nil If user can delete themselves this will need to return.  Plus determine admin or not.
    redirect_to movies_url, alert: "Account successfully Deleted!"
  end

  private

  def require_correct_user
    @user = User.find(params[:id])
    redirect_to root_url unless current_user?(@user)
    #unless current_user?(@user)
    #  redirect_to root_url
    #end
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end




end
