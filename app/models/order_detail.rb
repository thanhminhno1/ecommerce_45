class OrderDetail < ApplicationRecord
  belongs_to :product
  belongs_to :order

  validates :price, presence: true
  validates :quantity, presence: true
end
