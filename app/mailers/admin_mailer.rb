class AdminMailer < ApplicationMailer
  def monthly_email users
    @orders = Order.by_month(Date.today-Setting.order.one_month_ago.month)
                   .joins(:order_details).group_by_day("orders.updated_at")
                   .sum("order_details.price*order_details.quantity")
    mail to: users.pluck(:email), subject: t("mailer.admin.monthly_revenue_subject")
  end
end
