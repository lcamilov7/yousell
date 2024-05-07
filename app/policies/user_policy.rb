class UserPolicy < BasePolicy
  # definimos los metodos de Users controller que necesitan autorizacion para ejecutarse [edit update] show no necesita autorizacion
  # @item sale de BasePolicy clase padre, en este caso @item seria un usuario

  def edit
    @item == Current.user
  end

  def update
    @item == Current.user
  end
end
