class UsersController < ApplicationController
  LIKED_REQUEST = 'liked'
  before_action :set_user, only: %i[show]

  def show
    @articles = if liked_request?
                  Article.where(id: @user.likes.select(:article_id)).includes(:user).order(created_at: :desc).page(params[:page])
                else
                  @user.articles.order(created_at: :desc).page(params[:page])
                end
  end

  def liked_request?
    params[:liked] == LIKED_REQUEST
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end