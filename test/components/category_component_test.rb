# frozen_string_literal: true

require "test_helper"

class CategoryComponentTest < ViewComponent::TestCase
  test 'component render an empty category <a> tag' do
    assert_equal(
      %(<a class=\"bg-orange-500 text-white hover:bg-orange-700 px-4 py-2 rounded-2xl drop-shadow-sm\" href=\"/\">All</a>),
      render_inline(CategoryComponent.new).css('a').to_html
    )
  end

  test 'component render category <a> tag' do
    assert_equal(
      %(<a class=\"category bg-neutral-600 text-gray-200 hover:bg-orange-500 px-4 py-2 rounded-2xl drop-shadow-sm\" href=\"/?category_id=630261496\">Videogames</a>),
      render_inline(CategoryComponent.new(category: categories(:videogames))).css('a').to_html
    )
  end
end
