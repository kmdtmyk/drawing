class RenameColumnWitdhToDrawings < ActiveRecord::Migration[5.0]
  def change
    rename_column :drawings, :witdh, :width
  end
end
