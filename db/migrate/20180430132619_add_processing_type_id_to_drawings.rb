class AddProcessingTypeIdToDrawings < ActiveRecord::Migration[5.0]
  def change
    add_reference :drawings, :processing_type, foreign_key: true
  end
end
