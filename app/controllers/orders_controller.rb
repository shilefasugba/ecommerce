class OrdersController < ApplicationController
  def index
    @orders = current_user.orders
  end

  def show
    @order = current_user.orders.find(params[:id])
  end

  def new
    @order = Order.new
  end

  def create
    @order = current_user.orders.new(order_params)
    @order.billing_address.user = current_user  if @order.billing_address.present?
    @order.shipping_address.user = current_user  if @order.shipping_address.present?
    

    if @order.valid? && @order.errors.empty?
      @order.save
      
      redirect_to orders_path, notice: 'Success'
    else
      render :new
    end
  end

  private

  def order_params
    allow_params = [:stripe_card_token, :shipping_address_id, :billing_address_id]
    allow_params << { billing_address_attributes: [:address1, :address2, :city, :state_province_id, :first_name, :last_name, :postal_code] } unless params[:order][:billing_address_id].present?
    allow_params << { shipping_address_attributes: [:address1, :address2, :city, :state_province_id, :first_name, :last_name, :postal_code] } unless params[:order][:shipping_address_id].present?

    params.require(:order).permit(allow_params)
  end
end
