class AddTrackingCodeToOrders < ActiveRecord::Migration[8.1]
  def change
    add_column :orders, :tracking_code, :string
  end
end
