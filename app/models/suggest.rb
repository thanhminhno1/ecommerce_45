class Suggest < ApplicationRecord
  belongs_to :user

  enum status: {pending: 0, seen: 1}

  has_attached_file :image,
    styles: {medium: Settings.suggest.size_medium,
             thumb: Settings.suggest.size_thumb}

  validates_attachment :image,
    content_type: {content_type: Settings.suggest.image_accept}
  validates :content, presence: true,
    length: {maximum: Settings.suggest.content_max_length}
end
