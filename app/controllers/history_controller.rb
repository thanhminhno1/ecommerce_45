class HistoryController < ApplicationController
  layout "home"

  before_action :authenticate_user!
  authorize_resource class: Order

  def index
    @orders = current_user.orders.data_history.order_by_time.group("orders.id")
                          .page(params[:page]).per(Settings.order.per_page)
  end
end
