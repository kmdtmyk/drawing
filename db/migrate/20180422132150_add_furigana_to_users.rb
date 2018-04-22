class AddFuriganaToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :furigana, :string
  end
end
