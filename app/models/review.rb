class Review < ApplicationRecord
  t.belongs_to :user
  t.belongs_to :product

  validates :number_star, presence: true
end
