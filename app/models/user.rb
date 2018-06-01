class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
         :trackable, :validatable, :omniauthable,
         omniauth_providers: %i(facebook google_oauth2)
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
    length: {maximum: Settings.user.name_max_length}, unless: ->{from_omniauth?}
  validates :email, presence: true, uniqueness: {case_sensitive: false},
    length: {maximum: Settings.user.email_max_length},
    format: {with: VALID_EMAIL_REGEX}
  validates :phone_number, presence: true,
    length: {maximum: Settings.user.phone_number_max_length},
    format: {with: VALID_PHONE_NUMBER_REGEX}, unless: ->{from_omniauth?}
  validates :address, presence: true,
    length: {maximum: Settings.user.address_max_length}, unless: ->{from_omniauth?}

  def downcase_email
    self.email = email.downcase
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name
    end
  end

  private

  def from_omniauth?
    provider && uid
  end
end
