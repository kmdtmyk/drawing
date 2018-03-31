class CreateCustomers < ActiveRecord::Migration[5.0]
  def change
    create_table :customers do |t|
      t.string :name
      t.string :short_name
      t.integer :display_order
      t.boolean :order_flag, default: false, null: false
      t.boolean :outsource_flag, default: false, null: false

      t.timestamps
    end
  end
end
