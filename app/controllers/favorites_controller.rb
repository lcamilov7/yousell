class FavoritesController < ApplicationController
  def index
    # @favorites = Current.user.favorites Esta linea no es necesaria porque desde la vista index de favorites haremos una peticion asincrona
    # al index de products para que nos traiga solo los proructs que tienen favorite del current user
    # obtubimos los favoritos del current user en el index de favorites usando turbo frame tag y añadiendo filtro por favorites en querie de FindProduct con el param [:favorites]
  end

  def create
    product.favorite! # Metodo de clase para el produto que crea un favorito para el producto con el Current.user! esta en el modelo de product
    respond_to do |format|
      format.html { redirect_to(product_path(product)) } # LOS TEST NO INTERPRETAN TURBO STREAM, POR ESO DEJAMOS HTML TAMBIEN (no javascript porque turbo usa javascript)
      format.turbo_stream do
        # Lo que hace este render es coger el elemento con id='favorite' que se encuentra en el partial dado con variables locales dadas y lo reemplazara por el mismo si hubo cambios, en este caso el cambio es que se muestre para dar like o dislike
        render(turbo_stream: turbo_stream.replace('favorite', partial: 'products/favorite', locals: { product: product }) )
      end
    end
  end

  def destroy
    product.unfavorite!
    respond_to do |format|
      format.html { redirect_to(product_path(product), status: :see_other) }
      format.turbo_stream do
        render(turbo_stream: turbo_stream.replace('favorite', partial: 'products/favorite', locals: { product: product }))
      end
    end
  end

  def product # Memoization, para que cada vez q invoamos el metodo product en el mismo metodo no tenga que hacer cada vez una consulta para buscar el mismo producto una y otra vez sino que lo guarda en el cache, por ejemplo en el metodo create llamamos a product 2 veces pero no hay necesidad de hacer una consulta sql 2 veces para el mismo resutado
    @product ||= Product.find(params[:product_id]) # El nombre de la variable de instancia debe ser igual al del metodo
  end
end
