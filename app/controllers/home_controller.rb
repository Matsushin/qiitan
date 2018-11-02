class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @articles = Article.order(created_at: :desc)
  end
end