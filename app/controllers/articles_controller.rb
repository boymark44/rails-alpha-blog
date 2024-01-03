class ArticlesController < ApplicationController

  # Show actions are used to show a single article or items in a resource collection.
  def show
    @article = Article.find(params[:id])
  end

  # Display all the existing articles from our database.
  def index
    @articles = Article.all
  end

  # Display the form to create a new article.
  def new
    @article = Article.new
  end

    # The edit action is used to display the form to edit an existing article.
  def edit
    @article = Article.find(params[:id])
  end


  # Create a new article.
  def create
    #@article = Article.new(params.require(:article).permit(:title, :description))
    @article = Article.new(article_params)
    if @article.save
      flash[:notice] = "Article was created, successfully."
      redirect_to article_path(@article)
    else
      render 'new'
    end
  end

  # The update action is used to update an existing article.
  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      flash[:notice] = "Article was updated, successfully."
      redirect_to article_path(@article)
    else
      render 'edit'
    end
  end

  private

  # The article_params method is used to whitelist the parameters that are passed to the create and update actions.
  def article_params
    params.require(:article).permit(:title, :description) # Whitelist the parameters.
  end


end
