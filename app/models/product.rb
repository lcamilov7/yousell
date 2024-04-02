class Product < ApplicationRecord
  include PgSearch::Model

  has_one_attached :photo
  belongs_to :category

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
end
