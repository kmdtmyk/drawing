class AddCreatedUserIdToDrawings < ActiveRecord::Migration[5.0]
  def change
    add_reference :drawings, :create_user, foreign_key: { to_table: :users }
    add_reference :drawings, :update_user, foreign_key: { to_table: :users }
  end
end
