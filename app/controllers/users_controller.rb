class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :require_user, only: [:edit, :update]
  before_action :require_same_user, only: [:edit, :update, :destroy]


  def show
    # set_user => @user = User.find(params[:id])
    # In order to make sure that the user is only able to see their own articles,
    # we made the @articles variable an instance variable available to the view.
    @articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end

  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Welcome to the Alpha Blog, #{@user.username}!"
      redirect_to articles_path
    else
      render 'new'
    end
  end

  def edit
    # set_user => @user = User.find(params[:id])
  end

  def update
    # set_user => @user = User.find(params[:id])
    # Check if the password is blank and remove it from the parameters if it is.
    if params[:user][:password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end

    if @user.update(user_params)
      flash[:notice] = "Your account information was successfully updated."
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    # set_user => @user = User.find(params[:id])
    @user.destroy
    session[:user_id] = nil if @user == current_user
    flash[:notice] = "Account and all associated articles successfully deleted"

    redirect_to articles_path
  end

  private

  def user_params
    # :user is a top-level key
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def require_same_user
    if current_user != @user && !current_user.admin?
      flash[:alert] = "You can only edit or delete your own account!"
      redirect_to @user
    end
  end

end
