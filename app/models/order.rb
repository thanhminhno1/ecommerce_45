class Order < ApplicationRecord
  has_many :order_details
  belongs_to :user

  enum status: {pendding: 0, rejected: 1, accpeted: 2}

  VALID_PHONE_NUMBER_REGEX = /\d[0-9]\)*\z/
  validates :name, presence: true,
    length: {maximum: Settings.user.name_max_length}
  validates :phone_number, presence: true,
    length: {maximum: Settings.user.phone_number_max_length},
    format: {with: VALID_PHONE_NUMBER_REGEX}
  validates :address, presence: true,
    length: {maximum: Settings.user.address_max_length}
end
