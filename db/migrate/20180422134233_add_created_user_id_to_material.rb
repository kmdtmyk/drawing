class AddCreatedUserIdToMaterial < ActiveRecord::Migration[5.0]
  def change
    add_reference :materials, :create_user, foreign_key: { to_table: :users }
    add_reference :materials, :update_user, foreign_key: { to_table: :users }
  end
end
