class Order < ActiveRecord::Base
  validates :name, :address, :email, presence: true
  validates :pay_type, inclusion: PayType.all.map(&:name)
  has_many :line_items, dependent: :destroy

  def add_line_items_from_cart(cart)
    cart.line_items.each do |line_item|
      line_item.cart_id = nil
      line_items << line_item
    end
  end
end
