require 'test_helper'

class OrderNotifierTest < ActionMailer::TestCase
  test "received" do
    order = orders(:one)
    mail = OrderNotifier.received order
    assert_equal "Pragmatic Store Order Confirmation", mail.subject
    assert_equal [order.email], mail.to
    assert_equal ["support@depot.com"], mail.from
    assert_match /1 x Programming Ruby 1.9/, mail.body.encoded
  end

  test "shipped" do
    order = orders(:one)
    mail = OrderNotifier.shipped order
    assert_equal "Pragmatic Store Order Shipped", mail.subject
    assert_equal [order.email], mail.to
    assert_equal ["support@depot.com"], mail.from
    assert_match /<td>1<\/td>\s*<td>Programming Ruby 1.9<\/td>/,
      mail.body.encoded
  end

end
