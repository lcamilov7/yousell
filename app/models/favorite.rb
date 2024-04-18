class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates :user, uniqueness: { scope: :product } # Para que un usuario no like dos veces al mismo pdcto!
end
