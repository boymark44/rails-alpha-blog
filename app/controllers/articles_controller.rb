class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  # Show actions are used to show a single article or items in a resource collection.
  def show
    # set_article => @article = Article.find(params[:id])
  end

  # Display all the existing articles from our database.
  # Also has a basic search feature.
  def index
    if params[:search].present?
      # Adjust the query to match your search requirements
      @articles = Article.where("title LIKE ? OR description LIKE ?", "%#{params[:search]}%", "%#{params[:search]}%").paginate(page: params[:page], per_page: 5)
    else
      @articles = Article.paginate(page: params[:page], per_page: 5)
    end
  end

  # Display the form to create a new article.
  def new
    @article = Article.new
  end

  # Create a new article.
  def create
    @article = Article.new(article_params)
    @article.user = current_user # This is a workaround to get the user id.
    if @article.save
      flash[:notice] = "Article was created, successfully."
      redirect_to article_path(@article)
    else
      render 'new'
    end
  end

  # The edit action is used to display the form to edit an existing article.
  def edit
  # set_article => @article = Article.find(params[:id])
  end

  # The update action is used to update an existing article.
  def update
    # set_article => @article = Article.find(params[:id])
    if @article.update(article_params)
      flash[:notice] = "Article was updated, successfully."
      redirect_to article_path(@article)
    else
      render 'edit'
    end
  end

  # The destroy action is used to delete an existing article.
  def destroy
    # set_article => @article = Article.find(params[:id])
    @article.destroy

    redirect_to articles_url
  end


  private # Applying the DRY Principle.


  # The article_params method is used to whitelist the parameters that are passed to the create and update actions.
  def article_params
    params.require(:article).permit(:title, :description) # Whitelist the parameters.
  end

  # The set_article method is used to find the article that is being show, edited, updated and destroyed.
  def set_article
    @article = Article.find(params[:id])
  end

end
