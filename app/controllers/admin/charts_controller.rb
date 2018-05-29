class Admin::ChartsController < Admin::BaseController

  authorize_resource class: Order

  def index
    @params_search = chart_params
    case @params_search[:type]
    when "year"
      @params_search[:unit] = "month"
      @orders = Order.by_year(Date.strptime(@params_search[:year], "%Y"))
    when "month"
      @params_search[:unit] = "day"
      @orders = Order.by_month(Date.strptime(@params_search[:month], "%m/%Y"))
    when "range"
      @orders = Order.range(Date.strptime(@params_search[:from_date], "%m/%d/%Y"),
                            Date.strptime(@params_search[:to_date], "%m/%d/%Y"))
    else
      @orders = Order.by_year(Date.today)
    end
    @params_search[:type] = chart_params[:type] || "year"
    @orders = return_chart @orders, @params_search
  end

  private

  def chart_params
    params.permit :type, :unit, :year, :month, :from_date, :to_date
  end

  def return_chart orders, params_search
    if params_search[:unit] == "day"
      orders.approved.joins(:order_details).group_by_day("orders.updated_at")
            .sum("order_details.price*order_details.quantity")
    else
      orders.approved.joins(:order_details).group_by_month("orders.updated_at")
            .sum("order_details.price*order_details.quantity")
    end
  end
end
