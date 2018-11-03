class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @articles = Article.includes(:user).order(created_at: :desc).page(params[:page])
  end
end