FactoryBot.define do
  factory :item do
    item_name                  { Faker::Lorem.sentence }
    item_info                  { Faker::Lorem.sentence }
    category_id                { Faker::Number.between(from: 2, to: 11) }
    sale_status_id             { Faker::Number.between(from: 2, to: 7) }
    shipping_fee_status_id     { Faker::Number.between(from: 2, to: 3) }
    prefecture_id              { Faker::Number.between(from: 2, to: 48) }
    scheduled_delivery_id      { Faker::Number.between(from: 2, to: 4) }
    sell_price                 { Faker::Number.between(from: 300, to: 9_999_999) }

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end

    association :user
  end
end
