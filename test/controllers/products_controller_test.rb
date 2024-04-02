require 'test_helper'

class ProductsControllerTest < ActionDispatch::IntegrationTest
  test 'render a list of products' do
    get products_url
    assert_response(:success)
    assert_select('.product', 3)
    assert_select('.category', 3)
  end

  test 'render a list of products filtered by category' do
    get products_url(category_id: categories(:videogames).id)
    assert_response(:success)
    assert_select('.product', 2)
  end

  test 'render a list of products filtered by price' do
    get products_url(min_price: 140, max_price: 170)
    assert_response(:success)
    assert_select('h2', 'PS4 Fat')
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
    assert_redirected_to(product_path(Product.last))
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
    assert_redirected_to(product_path(products(:ps4)))
    assert_equal(flash[:notice], 'Product updated')
  end

  test 'should not allow to upda a product' do
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
