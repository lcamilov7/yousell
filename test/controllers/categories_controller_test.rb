require 'test_helper'

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  test 'render a list of categories' do
    get categories_path
    assert_response :success
    assert_select('h2', 'Categories')
  end

  test 'render a form for new category' do
    get new_category_path
    assert_response :success
    assert_select('form')
  end

  test 'should create a new category' do
    assert_difference('Category.count', 1) do
      post categories_path, params: {
        category: {
          name: 'Electronics'
        }
      }
    end
    assert_redirected_to(categories_path)
    assert_equal(flash[:notice], 'Category created')
  end

  test 'should render a form for edit a category' do
    get edit_category_path(categories(:videogames))
    assert_response :success
    assert_select('form')
  end

  test 'should update a category' do
    patch category_path(categories(:videogames)), params: {
      category: {
        name: 'Video Games xD'
      }
    }
    assert_redirected_to(categories_path)
    assert_equal(flash[:notice], 'Category updated')
  end

  test 'should destroy a category' do
    assert_difference('Category.count', -1) do
      delete category_path(categories(:clothes))
    end
    assert_redirected_to(categories_path)
    assert_equal(flash[:notice], 'Category deleted')
  end
end
