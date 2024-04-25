require 'open-uri'

class FetchCountryService
  def initialize(ip) # Recibimos una ip para crear la peticion a la API
    @ip = ip
  end

  def perform
    url = "http://ip-api.com/json/#{@ip}"
    ip_info_serialized = URI.open(url).read
    ip_info = JSON.parse(ip_info_serialized)
    status = ip_info['status']

    if status == 'success' # si la respuesta es success es porque la request.remote_ip ha enviado una ip valida, si n la respuesta es fail es porque estamos haciendola desde el localhost o poruque request.remote_ip no envio ip valida
      return ip_info['countryCode']
    else
      return nil
    end
  rescue # Si por algun motivo no funciona la url principal, debemos cubir esto con una exepcion con un rescue para el metodo perfomr, ya que si hay una expecion devoleremos nil
    return nil
  end
end
