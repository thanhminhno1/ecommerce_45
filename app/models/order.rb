class Order < ApplicationRecord
  has_many :order_details
  belongs_to :user

  enum status: {pending: 0, rejected: 1, approved: 2}

  VALID_PHONE_NUMBER_REGEX = /\d[0-9]\)*\z/
  validates :name, presence: true,
    length: {maximum: Settings.user.name_max_length}
  validates :phone_number, presence: true,
    length: {maximum: Settings.user.phone_number_max_length},
    format: {with: VALID_PHONE_NUMBER_REGEX}
  validates :address, presence: true,
    length: {maximum: Settings.user.address_max_length}

  scope :order_by_time, ->{order created_at: :desc}
  scope :by_status, ->(status){where status: status if status.present?}
  scope :order_by_status, ->{order status: :asc}
  scope :where_by_email_name_address, lambda{|query|
    joins(:user).where("users.email LIKE ? OR orders.address LIKE ?
    OR orders.name LIKE ?", "%#{query}%", "%#{query}", "%#{query}%")
  }
  scope :have_products, ->(products){joins(:order_details).where("order_details.product_id": products)}

  def created_format
    created_at.strftime(Settings.order.format_time)
  end
end
