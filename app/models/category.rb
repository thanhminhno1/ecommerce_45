class Category < ApplicationRecord
  has_many :products

  validates :name, presence: true,
    length: {maximum: Settings.category.name_max_length}
end
