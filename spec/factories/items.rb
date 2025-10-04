FactoryBot.define do
  factory :item do
    name              { Faker::Commerce.product_name }
    description       { Faker::Lorem.sentence }
    category_id       { 2 } # ActiveHashはID:1が「--」なので、2以上の値を指定
    item_status_id    { 2 }
    shipping_fee_payer_id { 2 }
    prefecture_id     { 2 }
    delivery_day_id   { 2 }
    price             { Faker::Number.between(from: 300, to: 9999999) }
    association :user # 紐づくuserのFactoryBotを呼び出す

    # ActiveStorageをテストするための設定
    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end