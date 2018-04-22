class CreateNotices < ActiveRecord::Migration[5.0]
  def change
    create_table :notices do |t|
      t.string :title
      t.string :body
      t.datetime :post_datetime
      t.references :create_user, foreign_key: { to_table: :users }
      t.references :update_user, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
