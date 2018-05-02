class AddCreatedUserIdToCustomer < ActiveRecord::Migration[5.0]
  def change
    add_reference :customers, :create_user, foreign_key: { to_table: :users }
    add_reference :customers, :update_user, foreign_key: { to_table: :users }
  end
end
