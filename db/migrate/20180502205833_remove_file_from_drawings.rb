class RemoveFileFromDrawings < ActiveRecord::Migration[5.0]
  def change
    remove_column :drawings, :file, :string
  end
end
