class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, alert: t("controller.session.not_permission")
  end

  protected

  def after_sign_in_path_for resource
    current_user.admin? ? admin_orders_path : root_path
  end
end
