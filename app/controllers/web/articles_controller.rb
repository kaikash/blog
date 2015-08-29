class Web::ArticlesController < Web::ApplicationController
  authorize_resource

  def index
    @articles = Article.all
  end

  def show
    @article = Article.find params[:id]
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new article_params
    @article.user = current_user
    @article.find_hashtags
    if @article.save
      redirect_to :controller => 'web/articles', :action => 'show', :id => @article
    else
      render :new
    end
  end

  def destroy
    @article = Article.find params[:id]
    if @article.destroy
      return redirect_to action: :index
    end
    render plain: "Error has occured."
  end

  private
  def article_params
    params.require(:article).permit(:title, :content)
  end
end
