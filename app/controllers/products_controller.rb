class ProductsController < ApplicationController
  before_action :product, only: %i[show edit update destroy]
  skip_before_action :protect_pages, only: %i[index show]

  def index
    @categories = Category.order('name ASC').load_async
    # @products = Product.with_attached_photo # Soluciona error n+1 query
    # @products = @products.where(category_id: params[:category_id]) if params[:category_id].present?

    # if params[:min_price].present? && params[:max_price].present?
    #   @products = @products.where("price BETWEEN #{params[:min_price]} AND #{params[:max_price]}")
    # elsif params[:min_price].present? && params[:max_price].blank?
    #   @products = @products.where("price >= #{params[:min_price]}")
    # elsif params[:min_price].blank? && params[:max_price].present?
    #   @products = @products.where("price <= #{params[:max_price]}")
    # end

    # @products = @products.global_search(params[:query]) if params[:query].present?

    # order_by = Product::ORDER_BY.fetch(params[:order_by]&.to_sym, Product::ORDER_BY[:newest])
    # @products = @products.order(order_by)

    @pagy, @products = pagy_countless(FindProducts.new.call(product_params_index), items: 12)
  end

  def show; end

  def new
    @product = Product.new
  end

  def create
    # @product = Current.user.products.new(product_params) REVISAR REFACTOR EN EL MODELO PRODUCT
    @product = Product.new(product_params)
    # @product.user_id = Current.user.id

    if @product.save
      redirect_to(product_path(@product), notice: 'Product created')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize!(product)
  end

  def update
    authorize!(product)
    if product.update(product_params)
      redirect_to(product_path(product), notice: 'Product updated')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize!(product)
    product.destroy
    redirect_to(products_path, notice: 'Product deleted', status: :see_other) # Redirect por defecto envia un 302, y esto no puede ser en el metodo delete, debemos sobreescribirlo SEE OTHER
  end

  private

  def product # Memoization para que cada vez que en el mismo metodo invoquemos este metodo llamado product no tengamos que hacer otra vez la misma consulta a la base de datos y que se quede en el cache
    @product ||= Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:title, :description, :price, :photo, :category_id)
  end

  def product_params_index
    params.permit(:category_id, :query, :min_price, :max_price, :order_by, :page, :user_id, :favorites) # page para permitir paginacion
  end
end
