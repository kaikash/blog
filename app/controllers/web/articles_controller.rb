class Web::ArticlesController < ApplicationController
  # load_and_authorize_resource
  # skip_authorization_check only: [:index, :show]
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
    if @article.save
      redirect_to :controller => 'web/articles', :action => 'show', :id => @article
    else
      render :new
    end
  end

  def destroy
    @article = Article.find params[:id]
    @article.destroy

    redirect_to action: :index
  end

  private
  def article_params
    params.require(:article).permit(:title, :content)
  end
end
