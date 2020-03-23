class CreateStoreOrders < ActiveRecord::Migration
  def change
    create_table :store_orders do |t|
      t.integer :order_id
      t.integer :store_id
      t.decimal :total
      t.decimal :total_shipping
      t.integer :payment_status_id
      t.integer :store_id
      t.decimal :subtotal
      t.decimal :tax_total
      t.string :stripe_charge_id
      t.integer :billing_address_id
      t.integer :shipping_address_id
      t.integer :status, default: 0
    end
  end
end
