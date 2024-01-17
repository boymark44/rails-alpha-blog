class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])

    # In order to make sure that the user is only able to see their own articles,
    # we made the @articles variable an instance variable available to the view.
    @articles = @user.articles
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
    if @user.update(user_params)
      flash[:notice] = "Your account information was successfully updated."
      redirect_to articles_path
    else
      render 'edit'
    end
  end

  private

  def user_params
    # :user is a top-level key
    params.require(:user).permit(:username, :email, :password)
  end

end
