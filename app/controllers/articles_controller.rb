class ArticlesController < ApplicationController
  before_action :set_article, only: %i[show edit update]

  def new
    @article = current_user.articles.build
  end

  def create
    @article = current_user.articles.build(article_params)
    if @article.save
      redirect_to article_path(@article), notice: t('common.flash.created')
    else
      flash.now[:alert] = @article.errors.full_messages.join('。')
      @article.errors.delete(:title)
      @article.errors.delete(:body)
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @article.update(article_params)
      redirect_to article_path(@article), notice: t('common.flash.updated')
    else
      flash.now[:alert] = @article.errors.full_messages.join('。')
      @article.errors.delete(:title)
      @article.errors.delete(:body)
      render :edit
    end
  end

  def preview; end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :body)
  end
end