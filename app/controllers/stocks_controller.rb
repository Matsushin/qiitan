class StocksController < ApplicationController
  before_action :set_article, only: %i[create destroy]
  before_action :set_stock, only: %i[destroy]

  def index 
    @articles = Article.where(id: current_user.stocks.select(:article_id))
                       .includes(:user)
                       .order(created_at: :desc)
                       .page(params[:page])
  end
  
  def create
    @stock = current_user.stocks.build(article: @article)
    if @stock.save
      render :save
    else
      render :save_error
    end
  end

  def destroy
    if @stock.destroy
      render :save
    else
      render :save_error
    end
  end

  private

  def set_article
    @article = Article.find(params[:article_id])
  end

  def set_stock
    @stock = current_user.stocks.find(params[:id])
  end
end