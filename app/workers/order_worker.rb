class OrderWorker
  include Sidekiq::Worker
  
  def perform(order_id)  
    order = Order.where(id: order_id).first
    
    if order.present? && order.status != 'success'
      order.charge

      if order.status == 'success'
        OrderMailer.send_success_to_admin(order)
        OrderMailer.send_success_to_user(order)
      else
        OrderMailer.send_error_to_admin(order)
      end
    end
  end
end