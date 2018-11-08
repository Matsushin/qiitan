class CommentsController < ApplicationController
  before_action :set_article, only: %i[create update destroy]
  before_action :set_comment, only: %i[update destroy]

  def create
    @comment = @article.comments.build(comment_params)
    @comment.user = current_user
    @comment.notifications.build(user: @article.user)
    if @comment.save
      Retryable.retryable { CommentMailer.comment_to_writer(@comment).deliver_now } unless current_user == @article.user
      redirect_to article_path(@article), notice: t('common.flash.created')
    else
      redirect_to article_path(@article), alert: @comment.errors.full_messages.join('。')
    end
  end

  def update
    unless @comment.update(comment_params)
      render :error
    end
  end

  def destroy
    render :error unless @comment.destroy
  end

  private

  def set_article
    @article = Article.find(params[:article_id])
  end

  def set_comment
    @comment = current_user.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end