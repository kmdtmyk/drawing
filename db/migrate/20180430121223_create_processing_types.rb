class CreateProcessingTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :processing_types do |t|
      t.string :name
      t.integer :display_order
      t.references :create_user, foreign_key: { to_table: :users }
      t.references :update_user, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
