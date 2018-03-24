class CreateDrawings < ActiveRecord::Migration[5.0]
  def change
    create_table :drawings do |t|
      t.string :part_number
      t.date :order_date
      t.integer :estimated_price
      t.integer :difficulty
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end
