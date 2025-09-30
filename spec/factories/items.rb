FactoryBot.define do
  factory :item do
    name { "MyString" }
    description { "MyText" }
    price { 1 }
    user { nil }
    category_id { 1 }
    item_status_id { 1 }
    shipping_fee_payer_id { 1 }
    prefecture_id { 1 }
    delivery_day_id { 1 }
  end
end
