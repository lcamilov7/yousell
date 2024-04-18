module Favoritable
  extend ActiveSupport::Concern

  included do
    def favorite?
      self.favorites.find_by(user: Current.user)
    end

    def favorite!
      self.favorites.create(user: Current.user)
    end

    def unfavorite!
      self.favorite?.destroy
    end
  end
end
