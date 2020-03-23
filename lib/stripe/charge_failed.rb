class ChargeFailed
  def call(event)
    failure_code = event['data']['object']['failure_code']
    store_order_id = event['data']['object']['metadata']['store_order_id']
    order_id = event['data']['object']['metadata']['order_id']
  
    if failure_code && (store_order_id.present? || order_id.present?)
      record = store_order_id.present? ? StoreOrder.where(id: store_order_id).first : Order.where(id: order_id).first
      
      if record.present?
        record.stripe_webhook_events.create(stripe_type: event['type'], stripe_failure_code: failure_code, stripe_id: event['id'], data: event['data'].as_json)
        record.update(status: :failure)

        if failure_code == 'card_declined'
          puts "CARD DECLINED FOR" + record.inspect
        elsif failure_code == 'insufficient_funds'
          puts "REFUND FROM: " + record.inspect + " FAILED, AND MONEY WITHDRAWN FROM PLATFORM ACCOUNT"
        end
      end
    end
  end
end


