require 'test_helper'

class ProductsControllerTest < ActionDispatch::IntegrationTest
  def setup
    login
  end

  test 'render a list of products' do
    get products_url
    assert_response(:success)
    assert_select('.product', 12)
    assert_select('.category', 9)
  end

  test 'render a list of products filtered by category' do
    get products_url(category_id: categories(:videogames).id)
    assert_response(:success)
    assert_select('.product', 7)
  end

  test 'render a list of products filtered by price' do
    get products_url(min_price: 140, max_price: 170)
    assert_response(:success)
    assert_select('h2', 'PS4 Fat')
  end

  test 'render a list of products filtered by query' do
    get products_url(query: 'switch')
    assert_response(:success)
    assert_select('h2', 'Nintendo Switch')
  end

  test 'render a list of products filtered by cheap' do
    get products_url(order_by: 'cheap')
    assert_response(:success)
    assert_select('.products .product:first-child h2', 'El hobbit')
  end

  test 'render a list of products filtered by expensive' do
    get products_url(order_by: 'expensive')
    assert_response(:success)
    assert_select('.products .product:first-child h2', 'Seat Panda clásico')
  end

  test 'render a list of products filtered by newest' do
    get products_url(order_by: 'newest')
    assert_response(:success)
    assert_select('.products .product:first-child h2', 'Google Pixel 4')
  end

  test 'render a detailed product page' do
    get product_url(products(:ps4))
    assert_response(:success)
    assert_select('.title', products(:ps4).title)
    assert_select('.description', products(:ps4).description)
    assert_select('.price', products(:ps4).price.to_s)
  end

  test 'render a form for new product' do
    get new_product_path
    assert_response(:success)
    assert_select('form', 1)
  end

  test 'should create a product' do
    assert_difference('Product.count', 1) do
      post products_path, params: {
        product: {
          title: 'Nintendo 64',
          description: 'Le faltan los cables',
          price: 45,
          category_id: categories(:videogames).id
        }
      }
    end
    assert_redirected_to(products_path)
    assert_equal(flash[:notice], 'Product created')
  end

  test 'should not allow to create a product' do
    assert_difference('Product.count', 0) do
      post products_path, params: {
        product: {
          title: 'Nintendo 64',
          price: 45
        }
      }
    end
    assert_template('products/new')
    assert_response(:unprocessable_entity)
  end

  test 'render a form for edit product' do
    get edit_product_path(products(:ps4))
    assert_response(:success)
    assert_select('form', 1)
  end

  test 'should update a product' do
    patch product_path(products(:ps4)), params: {
      product: {
        price: 160
      }
    }
    assert_redirected_to(products_path)
    assert_equal(flash[:notice], 'Product updated')
  end

  test 'should not allow to update a product' do
    patch product_path(products(:ps4)), params: {
      product: {
        title: nil
      }
    }
    assert_template('products/edit')
    assert_response(:unprocessable_entity)
  end

  test 'should delete a product' do
    assert_difference('Product.count', -1) do
      delete product_path(products(:ps4))
    end
    assert_redirected_to(products_path)
    assert_equal(flash[:notice], 'Product deleted')
  end
end
