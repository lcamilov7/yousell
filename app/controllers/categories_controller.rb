class CategoriesController < ApplicationController
  before_action :category, only: %i[edit update destroy]
  before_action :authorize!

  def index
    @categories = Category.order('name ASC')
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to(categories_path, notice: 'Category created')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @category.update(category_params)
      redirect_to(categories_path, notice: 'Category updated')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @category.destroy
    redirect_to(categories_path, notice: 'Category deleted', status: :see_other)
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def category
    @category = Category.find(params[:id])
  end
end
