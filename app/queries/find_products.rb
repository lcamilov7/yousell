class FindProducts
  attr_reader :products

  def initialize(products = initial_scope)
    @products = products
  end

  def call(params = {})
    scoped = products
    scoped = filter_by_category_id(scoped, params[:category_id])
    scoped = filter_by_price(scoped, params[:min_price], params[:max_price])
    scoped = filter_by_query(scoped, params[:query])
    scoped = filter_by_user(scoped, params[:user_id])
    scoped = filter_by_favorites(scoped, params[:favorites])
    sort(scoped, params[:order_by])
  end

  private

  def initial_scope
    Product.with_attached_photo
  end

    # IMPORTANTE EL .present? y .blank? !!

  def filter_by_category_id(scoped, category_id)
    return scoped unless category_id.present?

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
    return scoped unless user_id.present?

    return scoped.where(user_id: user_id)
  end

  def filter_by_favorites(scoped, favorites)
    return scoped unless favorites.present?

    # scoped.joins(:favorites) muestra todos los favoritos asociados a productos, luego el where explica primero con que tabla haremos where
    # y le decimos que en la tabla favorites, luego que de la tabla favorites solo los user_id que sean igual al Current.user.id
    scoped.joins(:favorites).where({ favorites: { user_id: Current.user&.id } })
  end

  def sort(scoped, order)
    order_by = Product::ORDER_BY.fetch(order&.to_sym, Product::ORDER_BY[:newest])
    return scoped.order(order_by)
  end
end
