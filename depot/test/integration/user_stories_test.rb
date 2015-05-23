require 'test_helper'

class UserStoriesTest < ActionDispatch::IntegrationTest
  fixtures :products

  test "Buying a product" do
    LineItem.delete_all
    Order.delete_all
    ruby_book = products :ruby

    # 1. go to store index
    get '/'
    assert_response :success
    assert_template 'index'

    # 2. select a product (ajax) and add to cart
    xml_http_request :post, '/line_items', product_id: ruby_book.id
    assert_response :success

    cart = Cart.find session['cart_id']
    assert_equal 1, cart.line_items.size
    assert_equal ruby_book, cart.line_items.first.product

    # 3. checkout
    get '/orders/new'
    assert_response :success
    assert_template 'new'

    # 4. fill up order form and submit
    post_via_redirect '/orders',
      order: {
        name: 'Dave Thomas',
        address: '1 Hacker Way',
        email: 'dave@example.com',
        pay_type: 'Check'
      }
    assert_response :success
    assert_template 'index'
    cart = Cart.find session[:cart_id]
    assert_equal 0, cart.line_items.size

    # 5 order verification
    orders = Order.all
    assert_equal 1, orders.size
    order = orders.first

    assert_equal 'Dave Thomas', order.name
    assert_equal '1 Hacker Way', order.address
    assert_equal 'dave@example.com', order.email
    assert_equal 'Check', order.pay_type

    assert_equal 1, order.line_items.size
    assert_equal ruby_book, order.line_items.first.product

    # 6 email verification
    mail = ActionMailer::Base.deliveries.last
    assert_equal ['dave@example.com'], mail.to
    assert_equal ['support@depot.com'], mail.from
    assert_equal 'Pragmatic Store Order Confirmation', mail.subject
  end
end
