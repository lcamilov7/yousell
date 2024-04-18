class FindProducts
  attr_reader :products

  def initialize(products = initial_scope) # Si no se le pasa nada al crear una nueva instancia FindProducts.new(vacio), entonces products = initial_scope
    @products = products
  end

  # Metodo de la llamada de búsqueda
  def call(params = {})
    scoped = products # products es @products gracias al attr_reader porque def products; @products; end
    scoped = filter_by_category_id(scoped, params[:category_id])
    scoped = filter_by_price(scoped, params[:min_price], params[:max_price])
    scoped = filter_by_query(scoped, params[:query])
    scoped = filter_by_user(scoped, params[:user_id])
    scoped = filter_by_favorites(scoped, params[:favorites])
    sort(scoped, params[:order_by])
  end

  private

  def initial_scope
    Product.with_attached_photo # with_attached_photo soluciona error n + 1 query
  end

    # IMPORTANTE EL .present? y .blank? !!

  def filter_by_category_id(scoped, category_id)
    return scoped unless category_id.present? # Devolvemos los mismos productos a menos que exista un param para category_id

    scoped = scoped.where(category_id: category_id)
    return scoped
  end

  def filter_by_price(scoped, min_price, max_price)
    if min_price.present? && max_price.present?
      scoped = scoped.where("price >= #{min_price} AND price <= #{max_price}")
    elsif min_price.present? && max_price.blank?
      scoped = scoped.where("price >= #{min_price}")
    elsif min_price.blank? && max_price.present?
      scoped = scoped.where("price <= #{max_price}")
    end
    return scoped
  end

  def filter_by_query(scoped, query)
    return scoped unless query.present?

    return scoped.global_search(query)
  end

  def filter_by_user(scoped, user_id)
    return scoped unless user_id.present? # Devolvemos los mismos productos a menos que exista un param para user_id

    return scoped.where(user_id: user_id)
  end

  def filter_by_favorites(scoped, favorites)
    return scoped unless favorites.present? # Devolvemos los mismos productos a menos que exista un param para favorites

    # scoped.joins(:favorites) muestra todos los favoritos asociados a productos, luego el where explica primero con que tabla haremos where
    # y le decimos que en la tabla favorites, luego que de la tabla favorites solo los user_id que sean igual al Current.user.id
    scoped.joins(:favorites).where({ favorites: { user_id: Current.user&.id } })
  end

  def sort(scoped, order)
    ### if params[:order].present? no tenemos que verificar esta condicion que es igual tambien a order_by.present? ya que order_by es igual a params[:order]. porque
      # el metodo fetch lo verifica automaticamente y si no esta presente los ordena
      # segun el segundo parametro pasado del metodo fetch, en este caso created_at DESC
    order_by = Product::ORDER_BY.fetch(order&.to_sym, Product::ORDER_BY[:newest])
      # El & verifica si existe el params[:order] en este caso order_by, y si existe lo convierte a symbolo
      # si no lo ponemos tendremos un error ya que seria nil y nil no puede convertitse a sym
      # EL METODO FETCH CONVIERTE AL HASH EN UNA KEY VALUE SEGUN LA KEY PASADA COMO PRIMER
      # ARGUMENTO, SI NO HAY PRIMER ARGUMENTO (&) ENTONCES CONVIERTE EL HASH EN EL SEGUNDO ARGUMENTO
    return scoped.order(order_by) # .load_async no funciona
    ### end
  # En una consulta solo podemos tener un metodo .order, si hay 2, no funciona,
  # .order va al final. y el metodo load_async tiene que ser el ultimo de todos,
  end
end
