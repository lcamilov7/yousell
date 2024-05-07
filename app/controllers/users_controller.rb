class UsersController < ApplicationController
  skip_before_action :protect_pages, only: :show # Si no esta logeado no puede modificar su usuario obviamente, pero si puede ver el perfil de un usuario

  def show
    # Esta vez quiero hallar el usuario por username, no por su id, tambien lo declaramos en routes
    user # @user = User.find_by!(username: params[:username]) # ese ! invocara el raise RecordNotFound si devuelve nil
    # @pagy, @products = pagy_countless(FindProducts.new.call({ user_id: @user.id }), items: 12) # añademos paginacion para este usuario pero solo buscaremos productos de este usuario
  end

  def edit
    authorize!(user)
    user
  end

  def update
    authorize!(user)
    if user.update(user_params) # Aqui hay problemas si lo qeu cambiamos es el username ya que despues no puede hacer redirect correctamente, REVISAR!
      redirect_to(user_path(user.username), notice: 'User updated') # Aqui no ponemos username: user.username porque ya establecimos que el param por default es username en las routes
    else
      render(:edit, status: :unprocessable_entity)
    end
  end

  private

  def user
    @user = User.find_by!(username: params[:username])
  end

  def user_params
    params.require(:user).permit(:email, :photo, :number) # De momento quitamos password y username
  end
end
