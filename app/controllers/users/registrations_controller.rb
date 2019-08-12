class Users::RegistrationsController < Devise::RegistrationsController
  def confirm_destroy
    @user = current_user
  end

  def complete_destroy
    @user = current_user
    if @user.valid_password?(registration_params[:password])
      @user.destroy
    else
      redirect_to users_edit_confirm_destroy_path, alert: "パスワードが間違っています。"
    end
  end

  private

  def registration_params
    params.require(:user).permit(:password)
  end
end