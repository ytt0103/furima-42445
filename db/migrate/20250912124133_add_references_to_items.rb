class AddReferencesToItems < ActiveRecord::Migration[7.1]
  def change
    add_reference :items, :item_status, foreign_key: true, null: false
    add_reference :items, :shipping_fee_payer, foreign_key: true, null: false
    add_reference :items, :delivery_day, foreign_key: true, null: false
  end
end