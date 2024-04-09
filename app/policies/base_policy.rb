class BasePolicy
  attr_reader :item

  def initialize(item)
    @item = item
  end

  def method_missing(m, *args, &block) # Si no hay metodo escrito devuelve falso oseaa no allowed
    false
  end
end
