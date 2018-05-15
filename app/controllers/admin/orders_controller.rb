class Admin::OrdersController < Admin::BaseController
  before_action :set_order, only: %i(approve reject show)

  def index
    @params_search = params[:order] || {status: "", name_or_address_or_email: ""}
    @orders = Order.by_status(@params_search[:status])
                   .where_by_email_name_address(@params_search[:name_or_address_or_email])
                   .order_by_status
                   .order_by_time.page(params[:page])
                   .per(Settings.order.per_page)
  end

  def show
    @details = @order.order_details.includes(:product)
  end

  def approve
    @order.approved!
    redirect_to admin_order_path(@order), success: t("controller.order.approve_success")
  end

  def reject
    @order.rejected!
    redirect_to admin_order_path(@order), success: t("controller.order.reject_success")
  end

  private

  def set_order
    @order = Order.find_by id: params[:id]
    return if @order
    flash[:notice] = t("controller.order.not_found")
    redirect_to admin_orders_path
  end
end
