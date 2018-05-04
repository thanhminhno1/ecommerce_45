class Product < ApplicationRecord
  belongs_to :category
  has_many :comments
  has_many :reviews
  has_many :order_details

  has_attached_file :image,
    styles: {medium: Settings.product.size_medium,
             thumb: Settings.product.size_thumb}

  validates_attachment :image,
    content_type: {content_type: Settings.product.image_accept}
  validates :name, presence: true,
    length: {maximum: Settings.product.name_max_length}
  validates :description, presence: true,
    length: {maximum: Settings.product.description_max_length}
end
