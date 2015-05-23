require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  fixtures :orders
  test "Only accept valid pay type" do
    order = orders :one
    assert order.valid?
    order.pay_type = 'Debit card'
    assert order.invalid?
  end
end
