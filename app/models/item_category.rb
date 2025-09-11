class ItemCategory < ApplicationRecord
  belongs_to :item # この行を追加
  belongs_to :category # この行を追加
end