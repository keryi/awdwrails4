credit_card = ActiveMerchant::Billing::CreditCard.new(
  number: '4111111111111111',
  month: '8',
  year: '2020',
  first_name: 'Yun',
  last_name: 'Ma',
  verification_value: '123'
)

puts "Is credit card #{credit_card.number} valid? #{credit_card.valid?}"
