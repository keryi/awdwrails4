require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  fixtures :products

  test "product attributes must not be empty" do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:image_url].any?
    assert product.errors[:price].any?
  end

  test "product price must be positive" do
    product = Product.new title: 'A title',
      description: 'A description',
      image_url: 'image.jpg'

    product.price = -1
    assert product.invalid?
    assert_equal ['must be greater than or equal to 0.01'],
      product.errors[:price]

    product.price = 0
    assert product.invalid?
    assert_equal ['must be greater than or equal to 0.01'],
      product.errors[:price]

    product.price = 1
    assert product.valid?
  end

  def new_product(image_url)
    Product.new title: 'A title',
      description: 'A description',
      price: 7.77,
      image_url: image_url
  end

  test "image url" do
    ok = %w{ fred.gif fred.jpg fred.png FRED.JPG FRED.Jpg
      http://a.b.c/x/y/z/fred.gif }
    bad = %w{ fred.doc fred.gif/more fred.gif.more }

    ok.each do |name|
      assert new_product(name).valid?, "#{name} should be valid"
    end

    bad.each do |name|
      assert new_product(name).invalid?, "#{name} should be invalid"
    end
  end

  test "product is not valid without a unique title" do
    product = Product.new title: products(:ruby).title,
      description: 'A description',
      price: 7.77,
      image_url: 'image.png'

    assert product.invalid?
    assert_equal [I18n.translate('errors.messages.taken')], product.errors[:title]
  end

  test "product is not valid without a unique image_url" do
    product = Product.new title: 'A title',
      description: 'A description',
      price: 7.77,
      image_url: products(:ruby).image_url

    assert product.invalid?
    assert_equal [I18n.translate('errors.messages.taken')], product.errors[:image_url]
  end

  test "product is not valid with price more than 10000" do
    product = products(:ruby)
    product.price = 10001

    assert product.invalid?
    assert_equal ['must be less than or equal to 10000'], product.errors[:price]
  end
end
