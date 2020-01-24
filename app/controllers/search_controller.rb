class SearchController < ApplicationController

  def index
    articles = if params[:stocked].present?
                 Article.where(id: current_user.stocks.select(:article_id))
               else
                 Article.all
               end

    @q = articles.includes(:user)
                 .order(created_at: :desc)
                 .ransack(params[:q])
    @articles = @q.result.page(params[:page])
    @filter_params = filter_params
  end

  private

  def filter_params
    params.fetch(:q, {}).permit(:title_or_body_cont).to_h
  end
end