class Product < ApplicationRecord
  include Favoritable # Logica relacionada con favoritos
  include PgSearch::Model

  has_one_attached :photo
  belongs_to :category
  belongs_to :user, default: -> { Current.user } # Asignamos de una vez el producto al current user al crearse
  has_many :favorites, dependent: :destroy

  validates :title, presence: true
  validates :description, presence: true
  validates :price, presence: true
  # validates :photo, presence: true # Causa error en tests

  pg_search_scope(:global_search, against: { title: 'A', description: 'B' }, using: { tsearch: { prefix: true } })

  ORDER_BY = {
    newest: 'id DESC',
    expensive: 'price DESC',
    cheap: 'price ASC'
  }

  def owner?
    self.user_id == Current.user&.id # Es importante este & para cuando no haya un current user no salga error
  end

  def broadcast
    broadcast_replace_to(self, partial: 'products/product_details', locals: { product: self })
  end
end
