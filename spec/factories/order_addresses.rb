FactoryBot.define do
  factory :order_address do
    # 配送先情報
    postal_code   { '123-4567' }
    prefecture_id { 2 } # 1以外（例：北海道）を設定
    city          { '横浜市緑区' }
    block         { '青山1-1-1' }
    building      { '柳ビル103' }
    phone_number  { '09012345678' }
    
    # 決済情報
    token         { 'tok_abcdefg12345' } # テスト用のダミートークン

    # アソシエーション
    # user_id と item_id はテスト側で上書きすることを想定
    # 例: FactoryBot.build(:order_address, user_id: user.id, item_id: item.id)
  end
end