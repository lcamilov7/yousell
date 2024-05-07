require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    login
    @user = users(:sara)
    @luis = users(:luis)
  end

  test 'should render a user profile' do
    get user_url(@user.username)

    assert_response(:success)
    assert_select('h2', "raticavivaz4´s products (#{@user.products.count})")
  end

  test 'should render edit form' do
    get edit_user_path(@user.username)
    assert_response(:success)
    assert_select('form', 1)
  end

  test 'should allow to update an user' do
    patch user_path(@user.username), params: {
      user: {
        email: 'laratoncita@gmail.com'
      }
    }
    assert_redirected_to(user_path(@user.username))
    assert_equal(flash[:notice], 'User updated')
  end

  test 'should not allow to render an edit form for other user' do
    get edit_user_path(@luis.username)
    assert_redirected_to(products_path)
    assert_equal(flash[:alert], 'Not authorized')
  end

  test 'should not allow to update other user' do
    patch user_path(@luis.username), params: {
      user: {
        email: 'elratoncito@gmail.com'
      }
    }
    assert_redirected_to(products_path)
    assert_equal(flash[:alert], 'Not authorized')
  end
end
