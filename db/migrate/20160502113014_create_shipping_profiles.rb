class CreateShippingProfiles < ActiveRecord::Migration
  def change
    create_table :shipping_profiles do |t|
      t.integer :shipping_type, default: 0
      t.integer :country_id
      t.integer :product_id
      t.integer :store_id
      t.boolean :all_countries
      t.decimal :base_price
      t.decimal :per_item
      t.decimal :extra_item
    end

    add_index :shipping_profiles, :country_id
    add_index :shipping_profiles, :product_id
    add_index :shipping_profiles, :store_id
  end
end
