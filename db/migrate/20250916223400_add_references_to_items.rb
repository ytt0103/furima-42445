class AddReferencesToItems < ActiveRecord::Migration[7.1]
  def change
    add_reference :items, :item_status, null: false, foreign_key: true
    add_reference :items, :shipping_fee_payer, null: false, foreign_key: true
    add_reference :items, :delivery_day, null: false, foreign_key: true
  end
end
