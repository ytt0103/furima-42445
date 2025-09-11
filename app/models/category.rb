class Category < ApplicationRecord
  has_many :item_categories # この行を追加
  has_many :items, through: :item_categories # この行を追加
end