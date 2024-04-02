class ProductsController < ApplicationController
  before_action :product, only: %i[show edit update destroy]

  def index
    @categories = Category.order('name ASC').load_async
    @products = Product.with_attached_photo.order('id DESC').load_async # Soluciona error n+1 query
    @products = @products.where(category_id: params[:category_id]) if params[:category_id].present?
  end

  def show; end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to(product_path(@product), notice: 'Product created')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @product.update(product_params)
      redirect_to(product_path(@product), notice: 'Product updated')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product.destroy
    redirect_to(products_path, notice: 'Product deleted', status: :see_other) # Redirect por defecto envia un 302, y esto no puede ser en el metodo delete, debemos sobreescribirlo SEE OTHER
  end

  private

  def product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:title, :description, :price, :photo, :category_id)
  end
end
