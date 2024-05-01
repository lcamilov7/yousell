require 'test_helper'

class Authentication::UsersControllerTest < ActionDispatch::IntegrationTest
  test 'should render a form for new user' do
    get new_user_path
    assert_response(:success)
  end

  test 'should create a new user' do
    # Aqui tambien debemos hacer una peticion "fake" a la api que da el valor a user.country y le pasamos de ip la localhost que si pasamos esa ip deberia devolver nil porque asi lo especificamos en fetch_country_service.rb
    stub_request(:get, 'http://ip-api.com/json/127.0.0.1').to_return(
      status: 200,
      body: {
        status: 'fail'
      }.to_json,
      headers: {}
    )

    assert_difference('User.count', 1) do
      post users_path, params: {
        user: {
          email: 'pepitoperez@hotmail.com',
          username: 'pepillo45',
          password: 'passwordverysecure',
          number: '3075659899'
        }
      }
    end
    assert_redirected_to(products_path)
  end

  test 'should not allow to create a new user' do
    stub_request(:get, 'http://ip-api.com/json/127.0.0.1').to_return(
      status: 200,
      body: {
        status: 'fail'
      }.to_json,
      headers: {}
    )

    assert_difference('User.count', 0) do
      post users_path, params: {
        user: {
          email: 'pepitoperez asddd hotmail.com',
          username: 'pepillo45',
          password: 'passwordverysecure'
        }
      }
    end
    assert_template('authentication/users/new')
    assert_response(:unprocessable_entity)
  end
end
