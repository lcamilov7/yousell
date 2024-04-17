class BasePolicy
  attr_reader :item # Para que cuando digamos item haga referencia a @item pero yo prefiero usar @item

  def initialize(item)
    @item = item
  end

  def method_missing(m, *args, &block) # Si no se encuentra el metodo escrito devuelve falso osea no allowed
    false
  end
end
