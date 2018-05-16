class User < ApplicationRecord
  has_secure_password
  before_save :downcase_email

  has_many :comments, dependent: :destroy
  has_many :suggests, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_one :history, dependent: :destroy

  enum role: {admin: 0, user: 1}

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  VALID_PHONE_NUMBER_REGEX = /\d[0-9]\)*\z/
  validates :name, presence: true,
    length: {maximum: Settings.user.name_max_length}
  validates :email, presence: true, uniqueness: {case_sensitive: false},
    length: {maximum: Settings.user.email_max_length},
    format: {with: VALID_EMAIL_REGEX}
  validates :phone_number, presence: true,
    length: {maximum: Settings.user.phone_number_max_length},
    format: {with: VALID_PHONE_NUMBER_REGEX}
  validates :address, presence: true,
    length: {maximum: Settings.user.address_max_length}

  def downcase_email
    self.email = email.downcase
  end
end
