class SessionsController < ApplicationController
  def new; end

  def edit; end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      if user.admin?
        redirect_to user_path
      else
        redirect_to product_path
      end
    else
      flash[:danger] = t("controller.session.invalid_em_pw")
      render :new
    end
  end

  def destroy
    session.delete :user_id
    @current_user = nil
    flash[:success] = t("controller.session.logout")
    redirect_to login_path
  end
end
