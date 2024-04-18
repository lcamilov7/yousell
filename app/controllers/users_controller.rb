class UsersController < ApplicationController
  skip_before_action :protect_pages

  # class NoUserFoundError < StandardError; end

  # rescue_from NoUserFoundError do
  #   redirect_to(products_path, alert: 'No User Found')
  # end

  def show
    @user = User.find_by!(username: params[:username]) # ese ! invocara el raise RecordNotFound si devuelve nil
    # raise NoUserFoundError if @user.nil?
    @pagy, @products = pagy_countless(FindProducts.new.call({ user_id: @user.id }), items: 12) # añademos paginacion para este usuario pero solo buscaremos productos de este usuario
  end

  # El error que creamos no era necesario pero igual lo quise dejar para practicar, si cuando hicimos User.find_by! agergabamos
  # ese ! ya de por si devolvia una excepecion en caso de que diera nil, (solo find_by devuelve nil, find nunca devuelve nil)
  # devolvia una excepcion de tipo ActiveRecord::RecordNotFound, y esta la podemos definir en el app controller asi
  # rescue_from ActiveRecord::RecordNotFound do
  #   redirect_to(products_path, alert: 'No User Found')
  # end
  # Esta forma es mil veces mejor ya que puede haber muchos casos en la app donde una busqueda de una instancia devuelva nil
  # y asi se podria reutilizar
  # PD al final si cambie a esta mejor version
end
