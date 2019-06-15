class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authorize_basic
  before_action :set_raven_context
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
<<<<<<< HEAD
    return unless %w(production staging).include?(Rails.env)
=======
    return unless Rails.env.production? || Rails.env.staging?
>>>>>>> 4c33a705bc3d70911d383676d646d6b26839fd15
    authenticate_or_request_with_http_basic('BA') do |name, password|
      name == ENV['BASIC_NAME'] && password == ENV['BASIC_PASSWORD']
    end
  end

  def set_raven_context
    Raven.user_context(id: session[:current_user_id])
    Raven.extra_context(params: params.to_unsafe_h, url: request.url)
  end
end
