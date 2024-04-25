class FetchCountryJob < ApplicationJob
  queue_as :default

  def perform(user_id, ip) # en background jobs no pasamos el usuario entero, pasamos el id y lo buscamos al usuario dentro del metodo NO PASAMOS OBJETOS ENTEROS
    user = User.find(user_id)
    country = FetchCountryService.new(ip).perform
    user.update(country: country) if country # Tiene que ser update porq el job se esta ejectuando despues de que se creo el usuario, if coutry porque si no encontro country entonces devuelve nil y nil ya lo tenia por defecto asi que no es necesario
  end
end
