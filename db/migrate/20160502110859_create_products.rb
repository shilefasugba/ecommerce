class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :title
      t.text :description
      t.integer :store_id
      t.integer :category_id
      t.boolean :track_inventory, default: false
      t.integer :stock_count
      t.decimal :shipping_weight_lbs
      t.integer :shipping_profile_id
      t.decimal :price
      t.string :stripe_id
      t.string :sku
      t.string :images
      t.string :slug
      t.decimal :tax

      t.timestamps 
    end

    add_index :products, :store_id
    add_index :products, :category_id
    add_index :products, :shipping_profile_id

  end
end

