class ArticlesController < ApplicationController
  # Show actions are used to show a single article or items in a resource collection.
  def show
    #binding.irb # => The debugger command
    @article = Article.find(params[:id])
  end

  
end
