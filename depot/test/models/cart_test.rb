require 'test_helper'

class CartTest < ActiveSupport::TestCase
  fixtures :products

  test "Add unique products" do
    cart = Cart.new
    line_item = cart.add_product products(:one).id
    line_item.save
    line_item = cart.add_product products(:two).id
    line_item.save

    assert_equal 2, cart.line_items.size
    assert_equal products(:one).price + products(:two).price, cart.total_price
  end

  test "Add duplicate products" do
    cart = Cart.new
    line_item = cart.add_product products(:one).id
    line_item.save
    line_item = cart.add_product products(:one).id
    line_item.save

    assert_equal 1, cart.line_items.size
    assert_equal 2, cart.line_items.first.quantity
    assert_equal 2 * products(:one).price, cart.total_price
  end
end
