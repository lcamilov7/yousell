require 'test_helper'

class Authentication::UsersControllerTest < ActionDispatch::IntegrationTest
  test 'should render a form for new user' do
    get new_user_path
    assert_response(:success)
  end

  test 'should create a new user' do
    assert_difference('User.count', 1) do
      post users_path, params: {
        user: {
          email: 'pepitoperez@hotmail.com',
          username: 'pepillo45',
          password: 'passwordverysecure'
        }
      }
    end
    assert_redirected_to(products_path)
  end

  test 'should not allow to create a new user' do
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
