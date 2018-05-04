class Order < ApplicationRecord
  has_many :order_details
  belongs_to :user

  enum status: {pendding: 0, rejected: 1, accpeted: 2}
end
