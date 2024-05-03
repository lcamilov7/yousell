require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:sara)
  end
  test 'should render a user profile' do
    get user_url(@user.username)

    assert_response(:success)
    assert_select('h2', "raticavivaz4´s products (#{@user.products.count})")
  end
end
