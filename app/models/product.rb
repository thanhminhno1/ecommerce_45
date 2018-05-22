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
  validates :price, presence: true
  validates :quantity, presence: true

  scope :ordered_by_name, ->{order name: :asc}
  scope :product_in_cart, ->(cart){where id: cart}
  scope :by_name, ->(query){where("name LIKE ?", "%#{query}%")}
  scope :by_name_or_desc, ->(query){where("name LIKE ? OR description LIKE ?", "%#{query}%", "%#{query}%")}
  scope :list_product, ->(query){where id: query}

  def self.import(file)
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(Settings.product.number_header)
    (Settings.product.start_column..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      product = new
      product.attributes = row.to_hash.slice(*row.to_hash.keys)
      product.save
    end
  end

  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
      when ".xls" then Roo::Excel.new(file.path)
      when ".xlsx" then Roo::Excelx.new(file.path)
      else raise I18n.t("controller.product.unknown_file_type") + file.original_filename
    end
  end
end
