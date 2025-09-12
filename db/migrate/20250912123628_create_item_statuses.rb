class CreateItemStatuses < ActiveRecord::Migration[7.1]
  def change
    create_table :item_statuses do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end