class ProductPolicy < BasePolicy
  # definimos los metodos de Products controller que necesitan autorizacion para ejecutarse [edit update destroy] show y index no necesitan autorizacion
  # @item sale de BasePolicy clase padre

  def edit
    @item.owner?
  end

  def update
    @item.owner?
  end

  def destroy
    @item.owner?
  end
end
