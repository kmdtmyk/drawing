class CreateDrawingOutsources < ActiveRecord::Migration[5.0]
  def change
    create_table :drawing_outsources do |t|
      t.references :drawing, foreign_key: true
      t.references :customer, foreign_key: true
      t.integer :purchase_price
      t.integer :display_order

      t.timestamps
    end
  end
end
