class Category < ApplicationRecord
  has_many :products, dependent: :restrict_with_exception # No permite eliminar categoria si hay productos asociados

  validates :name, presence: true
end
