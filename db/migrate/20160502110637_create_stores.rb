class CreateStores < ActiveRecord::Migration
  def change
    create_table :stores do |t|
      t.string :name
      t.string :stripe_id
      t.text :summary
      t.integer :user_id

      t.timestamps
    end

      add_index :stores, :user_id
  end
end
