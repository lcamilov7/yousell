class ProductChannel < ApplicationCable::Channel
  def subscribed
    stream_from('product_27')
  end
end
