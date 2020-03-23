class StoreOrderWorker
  include Sidekiq::Worker
  
  def perform(store_order_id)
    store_order = StoreOrder.where(id: store_order_id).first
    
    if store_order.present? && store_order.status != 'success'
      store_order.charge

      if store_order.status == 'success'
        StoreOrderMailer.send_success_to_admin(store_order)
        StoreOrderMailer.send_success_to_user(store_order)
      else
        StoreOrderMailer.send_error_to_admin(store_order)
      end
    end
  end
end
