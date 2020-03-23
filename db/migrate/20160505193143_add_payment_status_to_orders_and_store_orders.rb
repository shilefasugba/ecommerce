class AddPaymentStatusToOrdersAndStoreOrders < ActiveRecord::Migration
  def up
    add_column :orders, :payment_status, :string
    add_column :store_orders, :payment_status, :string
    add_column :orders, :fee, :decimal
  end

  def down
    remove_column :orders, :payment_status
    remove_column :store_orders, :payment_status
    remove_column :orders, :fee
  end
end
