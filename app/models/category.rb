class Category < ApplicationRecord
  acts_as_paranoid

  has_many :products, dependent: :destroy
  belongs_to :parent, class_name: Category.name, optional: true
  has_many :children, class_name: Category.name, foreign_key: :parent_id, dependent: :destroy

  validates :name, presence: true,
    length: {maximum: Settings.category.name_max_length}

  scope :list_parents, ->{where parent_id: nil}
  scope :ordered_by_name, ->{order name: :asc}
end
