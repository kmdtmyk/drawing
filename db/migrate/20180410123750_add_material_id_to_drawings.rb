class AddMaterialIdToDrawings < ActiveRecord::Migration[5.0]
  def change
    add_reference :drawings, :material, foreign_key: true
    remove_column :drawings, :material, :string
  end
end
