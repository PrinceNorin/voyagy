class User < ApplicationRecord
  API_KEY_LENGTH = 32

  has_secure_password

  validates :name, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, length: { minimum: 6 }, if: :should_validate_password?

  before_validation :normalize_email!
  before_create :generate_api_key!

  has_many :vessels, dependent: :destroy

  private

  def normalize_email!
    self.email = email.to_s.downcase
  end

  def generate_api_key!
    self.api_key = SecureRandom.urlsafe_base64(API_KEY_LENGTH)
  end

  def should_validate_password?
    new_record? || !password.nil?
  end
end
