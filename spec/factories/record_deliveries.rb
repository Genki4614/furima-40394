FactoryBot.define do
  factory :record_delivery do
    postal_code  { Faker::Number.leading_zero_number(digits: 3) + '-' + Faker::Number.leading_zero_number(digits: 4) }
    city         { '福岡市' }
    address      { '中央区大名2丁目12-34' }
    building     { '福岡市ビル3階' }
    prefecture_id { Faker::Number.between(from: 2, to: 48) }
    phone_number { Faker::Number.leading_zero_number(digits: rand(10..11)) }
    token { 'tok_abcdefghijk00000000000000000' }
  end
end
