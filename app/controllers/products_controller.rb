class ProductsController < ApplicationController
  before_action :product, only: %i[show edit update destroy]

  def index
    @products = Product.order('id DESC')
  end

  def show; end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to(product_path(@product), notice: 'Producto creado')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @product.update(product_params)
      redirect_to(product_path(@product), notice: 'Producto actualizado')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product.destroy
    redirect_to(products_path, notice: 'Producto eliminado')
  end

  private

  def product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:title, :description, :price)
  end
end
