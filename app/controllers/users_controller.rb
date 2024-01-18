class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])

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
      flash[:notice] = "Welcome to the Alpha Blog, #{@user.username}!"
      redirect_to articles_path
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
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

  private

  def user_params
    # :user is a top-level key
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end

end
