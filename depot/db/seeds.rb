# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Product.delete_all
Product.create! title: 'Programming 1.9 & 2.0',
  description: %{
    <p>Ruby is the fastest growing and most exciting dynamic language out there.
    If you need to get working program delivered fast, you need to add Ruby to
    your toolbox</p>
  },
  image_url: 'ruby.jpg',
  price: 49.95

unless PayType.any?
  ['Check', 'Credit card', 'Purchase order'].each do |name|
    PayType.create! name: name
  end
end
