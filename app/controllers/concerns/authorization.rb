module Authorization # Nombre del modulo debe corresponder al nombre del archivo
  # En este modulo meteremos toda la lógica relacionada con autorizaciones
  extend ActiveSupport::Concern

  included do
    class NotAuthorizedError < StandardError; end

    rescue_from NotAuthorizedError do
      redirect_to(products_path, alert: 'Not authorized')
    end

    private

    def authorize!(item = nil)
      # if item
      #   # is_allowed = item.user_id == Current.user.id
      #   # redirect_to(products_path, alert: 'Not authorized') unless is_allowed # Esto arrojaba error porque aca se redirecciona y hay metodos q tambien redireccionan
      #   is_allowed = ProductPolicy.new(item).edit
      # else
      #   # is_allowed = Current.user.admin?
      #   is_allowed = CategoryPolicy.new
      # end
      is_allowed = "#{controller_name.singularize}Policy".classify.constantize.new(item).send(action_name) # Metodo send(action_name) devuelve la accion que se esta llamando en el controlador
      raise NotAuthorizedError unless is_allowed # El raise corta todo flujo adicional como el redirect de los otros metodos, evita error de multiple redirect
    end
  end
end
