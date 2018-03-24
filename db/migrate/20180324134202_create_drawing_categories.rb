class CreateDrawingCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :drawing_categories do |t|
      t.references :drawing, foreign_key: true
      t.references :category, foreign_key: true
      t.integer :display_order

      t.timestamps
    end
  end
end
