class Item < ApplicationRecord
  belongs_to :user
  has_many :item_categories
  has_many :categories, through: :item_categories

  belongs_to :item_status # この行を追加
  belongs_to :shipping_fee_payer # この行を追加
  belongs_to :delivery_day # この行を追加
end