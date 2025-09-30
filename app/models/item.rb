class Item < ApplicationRecord
  belongs_to :user 

  # ActiveStorageの関連付け (画像)
  has_one_attached :image 

  # ActiveHashとの関連付け (選択肢)
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :item_status
  belongs_to :shipping_fee_payer
  belongs_to :prefecture
  belongs_to :delivery_day

  # ==============================
  # バリデーションの設定
  # ==============================
  with_options presence: true do
    validates :image # 画像が添付されているか

    validates :name, length: { maximum: 40 } # 商品名
    validates :description, length: { maximum: 1000 } # 商品の説明

    # ActiveHashの選択項目（id: 1, name: '---' 以外が選択されているか）
    # ActiveHashでid: 1は「---」つまり未選択状態を表すため、1以外であることをチェック
    validates :category_id, numericality: { other_than: 1, message: "can't be blank" }
    validates :item_status_id, numericality: { other_than: 1, message: "can't be blank" }
    validates :shipping_fee_payer_id, numericality: { other_than: 1, message: "can't be blank" }
    validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }
    validates :delivery_day_id, numericality: { other_than: 1, message: "can't be blank" }

    # 価格に関するバリデーション
    validates :price, 
      numericality: { 
        only_integer: true, # 整数であること
        greater_than_or_equal_to: 300, # 300円以上であること
        less_than_or_equal_to: 9_999_999, # 9,999,999円以下であること
        message: 'is invalid' # エラーメッセージ
      }
  end
end