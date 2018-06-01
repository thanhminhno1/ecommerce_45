class RejectMailWorker
  include Sidekiq::Worker

  def perform(order_id)
    order = Order.find_by order_id
    OrderMailer.rejected_email(order.user).deliver_later
  end
end
