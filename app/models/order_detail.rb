class OrderDetail < ApplicationRecord
  belongs_to :product
  belongs_to :order

  validates :price, presence: true
  validates :quantity, presence: true

  def total
    price * quantity
  end
end
