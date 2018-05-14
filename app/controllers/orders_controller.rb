class OrdersController < ApplicationController
  include ApplicationHelper

  layout "home"

  def index
    @order = Order.new
  end

  def create
    @order = current_user.orders.new order_params
    if @order.save
      details = []
      current_cart.each do |product|
        detail = @order.order_details.new product_id: product.id,
          quantity: product.quantity_in_cart, price: product.price
        details << detail
      end
      details = OrderDetail.import details
      session[:cart] = {}
      redirect_after_import details
    else
      render :index, notice: t("layout.order.order_fails")
    end
  end

  private

  def order_params
    params.require(:order).permit :name, :address, :phone_number
  end

  def redirect_after_import details
    flash[:notice] = if details.failed_instances.any?
                       t("layout.order.order_some_fails")
                     else
                       t("layout.order.order_success")
                     end
    redirect_to root_path
  end
end
