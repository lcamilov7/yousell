class ProductPolicy < BasePolicy
  # Metodos a sser comprobados
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
