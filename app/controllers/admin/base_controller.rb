class Admin::BaseController < ApplicationController
  include ApplicationHelper

  layout "admin"

  before_action :ensure_admin

  private

  def ensure_admin
    return if current_user && current_user.admin?
    flash[:danger] = t("controller.session.not_permission")
    redirect_to root_path
  end
end
