class BasePolicy
  attr_reader :item # Para que cuando digamos item haga referencia a @item pero yo prefiero usar @item

  def initialize(item)
    @item = item
  end

  def method_missing(m, *args, &block) # Este metodo se ejecuta si se llama un metodo de clase que no existe, por seguridad
    false # Devuelve false lo que hace que is_allowed del metodo authorize! sea false y eso hace q salte el error que redireccion al index de products y envia alert 'Invalid Url'
  end
end
