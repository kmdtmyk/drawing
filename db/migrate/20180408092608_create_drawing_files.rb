class CreateDrawingFiles < ActiveRecord::Migration[5.0]
  def change
    create_table :drawing_files do |t|
      t.references :drawing, foreign_key: true
      t.integer :display_order

      t.timestamps
    end
  end
end
