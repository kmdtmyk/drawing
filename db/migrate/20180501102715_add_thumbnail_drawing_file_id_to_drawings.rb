class AddThumbnailDrawingFileIdToDrawings < ActiveRecord::Migration[5.0]
  def change
    add_reference :drawings, :thumbnail_drawing_file, foreign_key: { to_table: :drawing_files }
  end
end
