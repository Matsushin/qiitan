class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authorize_basic
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    added_attrs = %i[username email profile_image profile_image_cache password password_confirmation]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
    devise_parameter_sanitizer.permit :sign_in, keys: added_attrs
  end

  private

  def authorize_basic
    return unless Rails.env.production?
    authenticate_or_request_with_http_basic('BA') do |name, password|
      name == ENV['BASIC_NAME'] && password == ENV['BASIC_PASSWORD']
    end
  end
end
