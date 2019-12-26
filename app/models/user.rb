class User < ApplicationRecord

  has_many :reviews, dependent: :destroy

  has_secure_password

  validates :name, presence: true

  validates :email, format: { with: /\S+@\S+/ }, uniqueness: true

  validates :password, length: { minimum: 10, allow_blank: true }

  def gravatar_id
    Digest::MD5::hexdigest(email.downcase)
  end

end
