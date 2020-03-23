class RenameCardItems < ActiveRecord::Migration
  def up
    rename_table :card_items, :cart_items
  end

  def down
    rename_table :cart_items, :card_items
  end
end
