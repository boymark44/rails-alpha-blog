class ApplicationController < ActionController::Base

  # The method will return the user object if the user is logged in, otherwise it will return nil.
  helper_method :current_user # This helper method will be accessible in all controllers and views.
  def current_user
    # Memoization means that the method will only be called once per request
    # and the result will be cached.
    # This is useful for methods that take a long time to run, like a database query.
    # The first time the method is called, the result is stored in a variable.
    # So that we won't have to run the method again in the same request and slows down the application.
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  helper_method :logged_in? # This helper method will be accessible in all controllers and views.
  def logged_in?
    !!current_user
  end

end
