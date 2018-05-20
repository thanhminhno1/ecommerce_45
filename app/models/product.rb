class Product < ApplicationRecord
  acts_as_paranoid

  belongs_to :category
  has_many :comments
  has_many :reviews
  has_many :order_details

  attr_accessor :quantity_in_cart

  has_attached_file :image, default_url: Settings.product.default_image,
    styles: {medium: Settings.product.size_medium,
             thumb: Settings.product.size_thumb}

  validates_attachment :image,
    content_type: {content_type: Settings.product.image_accept}
  validates :name, presence: true,
    length: {maximum: Settings.product.name_max_length}
  validates :description, presence: true,
    length: {maximum: Settings.product.description_max_length}

  scope :ordered_by_name, ->{order name: :asc}
  scope :product_in_cart, ->(cart){where id: cart}
  scope :by_name, ->(query){where("name LIKE ?", "%#{query}%")}
  scope :list_product, ->(query){where id: query}
end
