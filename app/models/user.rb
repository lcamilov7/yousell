class User < ApplicationRecord
  before_save :downcase_credentials

  has_secure_password
  has_many :products, dependent: :destroy
  has_many :favorites, dependent: :destroy

  validates :email, presence: true, uniqueness: true,
    format: {
      with: /\A([\w+-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i,
      message: :invalid
    }
  validates :username, presence: true, uniqueness: true,
    length: { in: 4..15 },
    format: {
      with: /\A[a-z0-9A-Z]+\z/,
      message: 'invalid is not valid only letter and number allowed' # o message: :invalid
    }
  validates :password, length: { minimum: 10 }

  def downcase_credentials
    self.username = self.username.downcase
    self.email = self.email.downcase
  end

  def admin?
    self.admin
  end
end
