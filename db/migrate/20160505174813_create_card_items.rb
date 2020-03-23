class CreateCardItems < ActiveRecord::Migration
  def change
    create_table :card_items do |t|
      t.integer :user_id
      t.integer :product_id
      t.integer :order_id
      t.integer :store_order_id
      t.integer :store_id
      t.integer :count, default: 0
      t.integer :shipping_profile_id, :integer
      t.integer :status, default: 0
    end

    add_index :card_items, :user_id
    add_index :card_items, :store_order_id
    add_index :card_items, :product_id
    add_index :card_items, :order_id
    add_index :card_items, :store_id
    add_index :card_items, :shipping_profile_id
  end
end


 