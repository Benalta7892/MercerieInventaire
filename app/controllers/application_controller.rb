class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :check_blocked!

  # before_action :store_return_to

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name avatar])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name avatar])
  end

  def after_sign_in_path_for(_resource)
    dashboard_path
  end

  def require_admin!
    redirect_to dashboard_path, alert: "Accès refusé." unless current_user&.admin?
  end

  def check_blocked!
    return unless current_user&.blocked?

    sign_out current_user
    redirect_to new_user_session_path, alert: "Votre compte a été bloqué."
  end

  private

  # def store_return_to
  #   return unless request.get?
  #   return if request.xhr?
  #   return if devise_controller?

  #   path = request.fullpath
  #   return if path.end_with?("/edit") || path.include?("/edit?")
  #   return if path.end_with?("/new")  || path.include?("/new?")

  #   session[:return_to] = path
  # end
end
