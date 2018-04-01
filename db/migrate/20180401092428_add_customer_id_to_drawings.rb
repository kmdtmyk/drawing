class AddCustomerIdToDrawings < ActiveRecord::Migration[5.0]
  def change
    add_reference :drawings, :customer, foreign_key: true
    add_column :drawings, :product_name, :string
    add_column :drawings, :material, :string
    add_column :drawings, :thickness, :float
    add_column :drawings, :witdh, :float
    add_column :drawings, :length, :float
    add_column :drawings, :estimate_date, :date
    add_column :drawings, :estimate_flag, :boolean, default: false, null: false
    add_column :drawings, :order_flag, :boolean, default: false, null: false
    add_column :drawings, :suspend_flag, :boolean, default: false, null: false
    add_column :drawings, :material_cost, :integer
    add_column :drawings, :process_cost, :integer
    add_column :drawings, :sales_price, :integer
    add_column :drawings, :memo, :text
  end
end
