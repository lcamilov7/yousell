require 'test_helper'

class Authentication::SessionsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:sara)
  end

  test 'should render new session form' do
    get new_session_path
    assert_response(:success)
  end

  test 'should login an user by email' do
    post sessions_path, params: {
      login: @user.email,
      password: 'testme'
    }

    assert_redirected_to(products_path)
  end

  test 'should login an user by username' do
    post sessions_path, params: {
      login: @user.username,
      password: 'testme'
    }

    assert_redirected_to(products_path)
  end

  test 'should logout an user' do
    login
    delete session_path(@user.id)
    assert_nil(session[:user_id])
    assert_redirected_to(products_path)
    assert_equal(flash[:notice], 'Logged out')
  end
end
