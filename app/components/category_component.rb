# frozen_string_literal: true

class CategoryComponent < ViewComponent::Base
  def initialize(category = nil)
    @category = category
  end

  def title
    # Si hay @category entonces el title sera el nombre de la categoria si no hay @category entonces es para all
    @category ? @category[:category].name.to_s : 'All'
  end

  def link
    # si hay @category entocnes el link sera products_path(category_id: id de esa @category) si no hay @category sera products_path para all
    @category ? products_path(category_id: @category[:category].id) : products_path
  end

  def active? # Este metodo es para saber cual category esta seleccionada en el momento
    return true if !@category && !params[:category_id] # Devuelve true si no hay categoria y tampco hay params[:category_id]
    params[:category_id].to_i == @category[:category].id if @category.present?
  end

  def background # Este metodo pondra un background a la category seleccionada en el momento para que se ueda saber cual estamos viendo
    active? ? 'bg-teal-500 text-white' : 'bg-white text-gray-600'
  end

  def classes
    @category ? "category #{background} px-4 py-2 rounded-2xl drop-shadow-sm hover:bg-gray-300" : "#{background} px-4 py-2 rounded-2xl drop-shadow-sm hover:bg-gray-300"
  end
end