module ApplicationHelper

  # Returns the Gravatar for the given user.
  def gravatar_for(user, options = { size: 80 })
    email_address = user.email.downcase
    hash = Digest::MD5.hexdigest(email_address)
    size = options[:size]
    gravatar_url = "https://www.gravatar.com/avatar/#{hash}?s=#{size}"
    image_tag(gravatar_url, alt: user.username, class: "rounded shadow mx-auto d-block")
  end

  def current_user
    # Memoization means that the method will only be called once per request
    # and the result will be cached.
    # This is useful for methods that take a long time to run, like a database query.
    # The first time the method is called, the result is stored in a variable.
    # So that we won't have to run the method again in the same request and slows down the application.
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

end
