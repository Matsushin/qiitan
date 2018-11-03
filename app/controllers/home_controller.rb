class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @q = Article.includes(:user).order(created_at: :desc).search(params[:q])
    @articles = @q.result.page(params[:page])
  end
end