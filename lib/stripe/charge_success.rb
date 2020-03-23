class ChargeSuccess
  def call(event)
    store_order_id = event['data']['object']['metadata']['store_order_id']
    order_id = event['data']['object']['metadata']['order_id']
    
    if store_order_id.present? || order_id.present?
      record = store_order_id.present? ? StoreOrder.where(id: store_order_id).first : Order.where(id: order_id).first
      
      if record.present?
        record.stripe_webhook_events.create(stripe_type: event['type'], stripe_id: event['id'], data: event['data'].as_json)
        record.update(status: :success)
        puts "NEW PAYMENT FOR: " + record.inspect
      end
    end
  end
end
