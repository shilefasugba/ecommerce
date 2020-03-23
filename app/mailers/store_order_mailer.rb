class StoreOrderMailer < BaseMailer
  
  def send_success_to_admin(store_order)
    @store_order = store_order
    mail(to: @store_order.store.user.email, subject: 'Success Order payment.')
  end

  def send_success_to_user(store_order)
    @store_order = store_order
    mail(to: @store_order.order.user.email, subject: 'Success Order payment, Thanks!')
  end

  def send_error_to_admin(store_order)
    @store_order = store_order
    mail(to: @store_order.store.user.email, subject: 'Failure Order payment!')
  end
end
