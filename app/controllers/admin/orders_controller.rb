class Admin::OrdersController < Admin::BaseController
  include ApplicationHelper

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
    OrderMailer.approved_email(@order.user).deliver
    redirect_to admin_order_path(@order), success: t("controller.order.approve_success")
  end

  def reject
    @order.rejected!
    unless rollback_quantity @order
      @order.pending!
      redirect_to admin_order_path(@order), notice: t("controller.order.error_update")
      return
    end
    OrderMailer.rejected_email(@order.user).deliver
    redirect_to admin_order_path(@order), success: t("controller.order.reject_success")
  end

  private

  def rollback_quantity order
    OrderDetail.transaction do
      begin
        order.order_details.each do |detail|
          detail.product.increment!(:quantity, detail.quantity)
        end
      rescue StandardError
        return false
      end
    end
  end

  def set_order
    @order = Order.find_by id: params[:id]
    return if @order
    flash[:notice] = t("controller.order.not_found")
    redirect_to admin_orders_path
  end
end
