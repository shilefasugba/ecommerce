class OrderMailer < BaseMailer
  def send_success_to_admin(order)
    @order = order
    mail(to: admin, subject: 'Success Order payment.')
  end

  def send_success_to_user(order)
    @order = order
    mail(to: @order.user.email, subject: 'Success Order payment, Thanks!')
  end

  def send_error_to_admin(order)
    @order = order
    mail(to: admin, subject: 'Failure Order payment!')
  end
end
