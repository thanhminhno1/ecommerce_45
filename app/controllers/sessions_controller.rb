class SessionsController < ApplicationController
  before_action :set_product_and_ensure_cart, only: %i(add_cart remove_cart update_cart)

  def new; end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_user user
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
    session[:cart][@product.id] = 1 if session[:cart].exclude?(@product.id)
    render json: {product: @product.to_json, session: session[:cart]}
  end

  def remove_cart
    if session[:cart].key?(@product.id.to_s)
      session[:cart].delete @product.id.to_s
    end
    render json: {product: @product.to_json, session: session[:cart]}
  end

  def update_cart
    if session[:cart].key?(@product.id.to_s)
      session[:cart][@product.id.to_s] = params[:quantity]
    end
    render json: {product: @product.to_json, session: session[:cart]}
  end

  private

  def set_product_and_ensure_cart
    @product = Product.find_by id: params[:id_product]
    session[:cart] ||= {}
    render json: {product: nil, session: session[:cart]} unless @product
  end

  def redirect_user user
    user.admin? ? redirect_to(admin_orders_path) : redirect_to(root_path)
    flash[:success] = t("controller.session.login_success")
  end
end
