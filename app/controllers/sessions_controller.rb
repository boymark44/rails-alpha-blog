class SessionsController < ApplicationController

  def new

  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # Session instance method is used to store data in the session hash
      # who we would like to be remembered from the session hash to the
      # browser until the session is destroyed.
      session[:user_id] = user.id
      flash[:notice] = "Logged in successfully!"
      redirect_to user
    else
      # Since we cant use flash with redirect_to, we use flash.now.
      flash.now[:alert] = "The email/password combination you entered is incorrect"
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil # Clear the session
    flash[:notice] = "Logged Out"
    redirect_to root_path
  end

end
