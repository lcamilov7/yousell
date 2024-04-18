class FavoritesController < ApplicationController
  def create
    product.favorite!
    redirect_to(product_path(product))
  end

  def destroy
    product.unfavorite!
    redirect_to(product_path(product), status: :see_other)
  end

  def product # Memoization, para que cada vez q invoamos el metodo product en el mismo metodo no tenga que hacer cada vez una consulta para buscar el mismo producto una y otra vez sino que lo guarda en el cache, por ejemplo en el metodo create llamamos a product 2 veces pero no hay necesidad de hacer una consulta sql 2 veces para el mismo resutado
    @product ||= Product.find(params[:product_id]) # El nombre de la variable de instancia debe ser igual al del metodo
  end
end
