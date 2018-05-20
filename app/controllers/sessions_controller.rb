class SessionsController < ApplicationController
  include ApplicationHelper

  before_action :set_product_and_ensure_cart, except: %i(create destroy)

  def new; end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_user user
    else
      flash[:danger] = t("controller.session.invalid_em_pw")
      redirect_to root_path
    end
  end

  def destroy
    session.delete :user_id
    @current_user = nil
    flash[:success] = t("controller.session.logout")
    redirect_to root_path
  end

  def add_cart
    return render_validate_fail unless validate_quantity_cart @product, 1
    if session[:cart].key?(@product.id.to_s)
      session[:cart][@product.id.to_s] += 1
    else
      session[:cart][@product.id.to_s] = 1
    end
    render_ajax @product
  end

  def remove_cart
    session[:cart].delete @product.id.to_s if session[:cart].key?(@product.id.to_s)
    render_ajax @product
  end

  def update_cart
    return render_validate_fail unless validate_quantity_cart @product, params[:quantity].to_i
    session[:cart][@product.id.to_s] = if session[:cart].key?(@product.id.to_s)
                                         session[:cart][@product.id.to_s] + params[:quantity].to_i
                                       else
                                         params[:quantity].to_i
                                       end
    render_ajax @product
  end

  def update_hard_cart
    return render_validate_fail unless validate_quantity_cart @product, params[:quantity].to_i, true
    session[:cart][@product.id.to_s] = params[:quantity].to_i if session[:cart].key?(@product.id.to_s)
    render_ajax @product
  end

  private

  def validate_quantity_cart product, quantity, update_hard = false
    if update_hard || !session[:cart].key?(@product.id.to_s)
      product.quantity >= quantity
    else
      product.quantity >= (quantity + session[:cart][@product.id.to_s])
    end
  end

  def render_validate_fail
    render json: {}, status: 400
  end

  def set_product_and_ensure_cart
    @product = Product.find_by id: params[:id_product]
    session[:cart] ||= {}
    render json: {product: nil, total: total_cart} unless @product
  end

  def redirect_user user
    user.admin? ? redirect_to(admin_orders_path) : redirect_to(root_path)
    flash[:success] = t("controller.session.login_success")
  end

  def render_ajax product
    render json: {product: product.to_json, total: total_cart}
  end
end
