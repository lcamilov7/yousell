# frozen_string_literal: true

require "test_helper"

class CategoryComponentTest < ViewComponent::TestCase
  test 'component render an empty category <a> tag' do
    assert_equal(
      %(<a class=\"bg-teal-500 text-white px-4 py-2 rounded-2xl drop-shadow-sm hover:bg-gray-300\" href=\"/\">All</a>),
      render_inline(CategoryComponent.new).css('a').to_html
    )
  end

  test 'component render category <a> tag' do
    assert_equal(
      %(<a class=\"category bg-white text-gray-600 px-4 py-2 rounded-2xl drop-shadow-sm hover:bg-gray-300\" href=\"/?category_id=630261496\">Videogames</a>),
      render_inline(CategoryComponent.new(category: categories(:videogames))).css('a').to_html
    )
  end
end