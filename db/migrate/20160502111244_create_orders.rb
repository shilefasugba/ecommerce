class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :user_id
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
      
      t.timestamps
    end

    add_index :orders, :billing_address_id
    add_index :orders, :shipping_address_id
    add_index :orders, :user_id
  end
end

