class CreateStripeWebhookEvents < ActiveRecord::Migration
  def change
    enable_extension 'hstore'
    
    create_table :stripe_webhook_events do |t|
      t.string   "stripe_id"
      t.string   "stripe_type"
      t.hstore   "data"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "order_id"
      t.string   "stripe_failure_code"
    end

    add_index :stripe_webhook_events, :order_id
  end
end
