class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  protected

  def after_sign_in_path_for resource
    current_user.admin? ? admin_orders_path : root_path
  end
end
