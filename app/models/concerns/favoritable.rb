module Favoritable
  extend ActiveSupport::Concern

  included do
    def favorite! # Exclamación significa que vamos a hacer cambios
      self.favorites.create(user: Current.user)
    end

    def find_favorite
      self.favorites.find_by(user: Current.user)
    end

    def unfavorite!
      self.find_favorite.destroy # Exclamación significa que vamos a hacer cambios
    end
  end
end
