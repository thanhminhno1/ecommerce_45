class SessionsController < ApplicationController
  before_action :set_product_and_ensure_cart, only: [:add_cart, :remove_cart]

  def new; end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      if user.admin?
        redirect_to user_path
      else
        redirect_to root_path
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
    redirect_to root_path
  end

  def add_cart
    session[:cart] << @product.id if session[:cart].exclude?(@product.id)
    render json: {product: @product.to_json, session: session[:cart]}
  end

  def remove_cart
    session[:cart].delete @product.id if session[:cart].include?(@product.id)
    render json: {product: @product.to_json, session: session[:cart]}
  end

  private

  def set_product_and_ensure_cart
    @product = Product.find_by id: params[:id_product]
    session[:cart] ||= []
    render json: {product: nil, session: session[:cart]} unless @product
  end
end
