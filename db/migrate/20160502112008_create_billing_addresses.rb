class CreateBillingAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.integer :user_id
      t.string :address1
      t.string :address2
      t.string :city
      t.string :state_province
      t.integer :country_id
      t.integer :state_province_id
      t.string :first_name
      t.string :last_name
      t.string :postal_code
      
      t.timestamps
    end

    add_index :addresses, :country_id
    add_index :addresses, :user_id
    add_index :addresses, :state_province_id
  end
end