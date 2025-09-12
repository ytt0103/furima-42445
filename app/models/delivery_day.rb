class DeliveryDay < ApplicationRecord
  has_many :items # この行を追加
end