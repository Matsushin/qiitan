class UsersController < ApplicationController
  LIKED_REQUEST = 'liked'
  before_action :set_user, only: %i[show]
  before_action :authenticate_user!, except: %i[completed_destroy]

  # def edit_password;end

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

  def confirm_destroy
    @user = current_user
    render :confirm_destroy, layout: "without_header"
  end

  def complete_destroy
    if current_user.valid_password?(user_params[:password])
      current_user.destroy
      sign_out
      redirect_to users_completed_destroy_path
    else
      redirect_to users_confirm_destroy_path, alert: "パスワードが間違っています。"
    end
  end

  def completed_destroy
    render :completed_destroy, layout: "without_header_and_footer.html"
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:password)
  end
end
