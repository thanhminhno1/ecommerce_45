class ApproveMailWorker
  include Sidekiq::Worker

  def perform(order_id)
    order = Order.find_by order_id
    OrderMailer.approved_email(order.user).deliver_later
  end
end
