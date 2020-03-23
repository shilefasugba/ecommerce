class CreateStateProvinces < ActiveRecord::Migration
  def change
    create_table :state_provinces do |t|
      t.string :name
      t.integer :country_id
      t.timestamps
    end

    add_index :state_provinces, :country_id
  end
end
