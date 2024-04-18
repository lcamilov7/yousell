module Authorization # Nombre del modulo debe corresponder al nombre del archivo
  # En este modulo meteremos toda la lógica relacionada con autorizaciones
  extend ActiveSupport::Concern

  included do
    class NotAuthorizedError < StandardError; end

    rescue_from NotAuthorizedError do
      redirect_to(products_path, alert: 'Not authorized') # Esto hace que se redireccione a products_url cuando se invoca este error
    end

    private

    def authorize!(item = nil)
      # if record # si se pasa un record como parametrso significa que es un producto entonces aplicamos logica para el producto
      #   is_allowed = record.user == Current.user
      # else
      #   is_allowed = Current.user.admin
      # end
      # if item
      #   # is_allowed = item.user_id == Current.user.id
      #   # redirect_to(products_path, alert: 'Not authorized') unless is_allowed # Esto arrojaba error porque aca se redirecciona y hay metodos q tambien redireccionan
      #   is_allowed = ProductPolicy.new(item).edit
      # else
      #   # is_allowed = Current.user.admin?
      #   is_allowed = CategoryPolicy.new
      # end

      # Aca creamos el nombre de la clase que vamos a invocar, si el controller name es products significa q estan llamando al metodo authorize desde products, osea que controller_name devuelve 'products', pero nuestra policy se llama ProductPolicy, entonces tenemos que quitarle el plural y ponerle mayuscula y tendremos ya el nombre de la clase que necesitamos invocar (carpeta policies), luego convertimos el string a constante porque al string no lo podemos usar para invocar una clase, luego creamos la instancia de la clase policy con .new, luego necesitamos saber desde que metodo se esta llamando al metodo authorize y lo sabremos con .send(action_name)
      is_allowed = "#{controller_name.singularize}Policy".classify.constantize.new(item).send(action_name) # Metodo send(action_name) devuelve la accion que se esta llamando en el controlador.
      raise NotAuthorizedError unless is_allowed # El raise corta todo flujo adicional como el redirect de los otros metodos como update, evita error de multiple redirect
    end
  end
end
