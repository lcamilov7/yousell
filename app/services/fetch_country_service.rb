require 'open-uri'

class FetchCountryService
  def initialize(ip = nil) # Recibimos una ip para crear la peticion a la API
    @ip = ip
  end

  def perform
    url = "http://ip-api.com/json/#{@ip}"
    ip_info_serialized = URI.open(url).read
    ip_info = JSON.parse(ip_info_serialized)

    return ip_info['countryCode']
  end
end
