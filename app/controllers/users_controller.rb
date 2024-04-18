class UsersController < ApplicationController
  skip_before_action :protect_pages

  def show
    # Esta vez quiero hallar el usuario por username, no por su id, tambien lo declaramos en routes
    @user = User.find_by!(username: params[:username]) # ese ! invocara el raise RecordNotFound si devuelve nil
    # @pagy, @products = pagy_countless(FindProducts.new.call({ user_id: @user.id }), items: 12) # añademos paginacion para este usuario pero solo buscaremos productos de este usuario
  end
end
