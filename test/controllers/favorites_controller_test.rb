require "test_helper"

class FavoritesControllerTest < ActionDispatch::IntegrationTest
  setup do
    login
    @product = products(:switch)
    @product2 = products(:ps4)
  end

  test 'should render a list of user favorites' do
    get favorites_path
    assert_response(:success)
    assert_select('h2', 'My Favorites')
  end

  test 'should allow to create favorite' do
    assert_difference('Favorite.count', 1) do
      post favorites_url(product_id: @product.id)
    end
  end

  test 'should not allow to create favorite' do
    assert_difference('Favorite.count', 0) do
      post favorites_url(product_id: @product2.id)
    end
  end

  test 'should allow to destroy favorite' do
    assert_difference('Favorite.count', -1) do
      delete favorite_url(product_id: @product2.id)
    end
  end
end
