class AddStoreOrderIdToStripeWenhookEvents < ActiveRecord::Migration
  def up
    add_column :stripe_webhook_events, :store_order_id, :integer
    add_index :stripe_webhook_events, :store_order_id
  end

  def down
    remove_column :stripe_webhook_events, :store_order_id
  end
end
