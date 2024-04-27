class ProductChannel < ApplicationCable::Channel
  def subscribed
    stream_from("product_#{params[:room]}") # El params
  end
end
