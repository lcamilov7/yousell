require 'test_helper'

class ProductsControllerTest < ActionDispatch::IntegrationTest
  test 'render a list of products' do
    get products_url
    assert_response(:success)

    assert_select('.product', 2)
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
          price: 45
        }
      }
    end
    assert_redirected_to(product_path(Product.last))
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
end
