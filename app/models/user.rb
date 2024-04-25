class User < ApplicationRecord
  before_save :downcase_credentials

  has_secure_password # Añade todos los metodos de contraseña encryptada y login y descomentamos gema bcrypt, tambien permite usar el metodo authenticate en instancias de User
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

  # Password no existe, es un campo virtual para password_digest, y el if es para que no se ejecute la validacion si no cambiamos la contraseña porque sino salta error cuando hagamos user.update en alguna instancia 
  validates :password, length: { minimum: 10 }, if: :password_digest_changed?

  def downcase_credentials
    self.username = self.username.downcase
    self.email = self.email.downcase
  end

  def admin?
    self.admin
  end
end
