module Errors
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound do # errores de cuando no se encuentra una instancia
      redirect_to(products_path, alert: 'Not Found')
    end
  end
end
