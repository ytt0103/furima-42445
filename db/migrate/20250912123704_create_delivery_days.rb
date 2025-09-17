class CreateDeliveryDays < ActiveRecord::Migration[7.1]
  def change
    create_table :delivery_days do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
