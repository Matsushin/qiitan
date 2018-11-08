class LikesController < ApplicationController
  before_action :set_article, only: %i[create destroy]
  before_action :set_like, only: %i[destroy]

  def create
    @like = current_user.likes.build(article: @article)
    @like.notifications.build(user: @article.user)
    if @like.save
      render :save
    else
      render :save_error
    end
  end

  def destroy
    if @like.destroy
      render :save
    else
      render :save_error
    end
  end

  private

  def set_article
    @article = Article.find(params[:article_id])
  end

  def set_like
    @like = current_user.likes.find(params[:id])
  end
end