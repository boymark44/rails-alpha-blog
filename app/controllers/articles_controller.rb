class ArticlesController < ApplicationController

  # Show actions are used to show a single article or items in a resource collection.
  def show
    @article = Article.find(params[:id])
  end

  # Display all the existing articles from our database.
  def index
    @articles = Article.all
  end


end
