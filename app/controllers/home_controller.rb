class HomeController < ApplicationController

  def index
    # @articles = Article.includes(:user).order(created_at: :desc).page(params[:page])
    @articles = Article.order(created_at: :desc).page(params[:page])
  end
end