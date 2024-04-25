require "test_helper"

class FetchCountryServiceTest < ActiveSupport::TestCase
  # Para testear con llamados a apis externas tenemos que hacerlo con webmock o alguna opcion que nos permita
  # correr muchas veces y simular el llamado a la api sin hacerlo de verdad porque agotaria nustros llamados a la api
  # y en algun momento deberiamos pagar y solo estamos testeando y queremos testear muchas veces. Aparte un llamado a
  # la api real es mucho tiempo de espera

  test 'should return "CA" with a valid ip from canada' do
    # Este stub simulará la petición a la api sin tener que hacerla realmente
    stub_request(:get, 'http://ip-api.com/json/24.48.0.1').to_return(
      status: 200,
      body: {
        status: 'success',
        countryCode: 'CA'
      }.to_json,
      headers: {}
    )
    assert_equal(FetchCountryService.new('24.48.0.1').perform, 'CA')
  end

  test 'should return nil with a invalid ip' do
    # Este stub simulará la petición a la api sin tener que hacerla realmente
    stub_request(:get, 'http://ip-api.com/json/ratica').to_return(
      status: 200,
      body: {
        status: 'fail'
      }.to_json,
      headers: {}
    )
    assert_nil(FetchCountryService.new('ratica').perform)
  end
end
