class Item < ApplicationRecord
  belongs_to :user # この行を追加
  has_many :item_categories # この行を追加
  has_many :categories, through: :item_categories # この行を追加
end