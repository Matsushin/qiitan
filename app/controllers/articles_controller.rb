class ArticlesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_article, only: %i[show edit update]

  def index
    @articles = current_user.articles.order(created_at: :desc)
  end

  def new
    @article = current_user.articles.build
  end

  def create
    @article = current_user.articles.build(article_params)
    if @article.save
      redirect_to articles_path, notice: t('common.flash.created')
    else
      flash.now[:alert] = @article.errors.full_messages.join('。')
      @article.errors.delete(:title)
      @article.errors.delete(:body)
      render :new
    end
  end

  def show
  end

  def edit

  end

  def update

  end

  def preview
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :body)
  end
end