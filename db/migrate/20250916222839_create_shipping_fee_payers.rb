class CreateShippingFeePayers < ActiveRecord::Migration[7.1]
  def change
    create_table :shipping_fee_payers do |t|
      t.string :name

      t.timestamps
    end
  end
end
