class RemoveColumnCategoryIdFromDrawing < ActiveRecord::Migration[5.0]
  def change
    remove_reference :drawings, :category, foreign_key: true
  end
end
