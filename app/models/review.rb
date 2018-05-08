class Review < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates :number_star, presence: true
end
