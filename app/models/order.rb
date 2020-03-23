class Order < ActiveRecord::Base
  attr_accessor :stripe_card_token, :card_number, :card_code, :card_month, :card_year

  enum status: [:unprocessed, :processed, :failure, :success]

  belongs_to :user
  belongs_to :billing_address, class_name: 'Address'
  belongs_to :shipping_address, class_name: 'Address'
  
  has_many :cart_items
  has_many :stripe_webhook_events
  has_many :store_orders
  
  validates :stripe_card_token, presence: true, if: :unprocessed?
  validates :user_id, presence: true
  validates :billing_address, presence: true
  validates :shipping_address, presence: true
  validates :total, presence: true, unless: :unprocessed?
  validates :total_shipping, presence: true, unless: :unprocessed?
  validates :subtotal, presence: true, unless: :unprocessed?
  validates :tax_total, presence: true, unless: :unprocessed?

  def processed?
    status == 'processed'
  end

  accepts_nested_attributes_for :billing_address, :shipping_address, allow_destroy: true

  before_create :create_stripe_customer_token
  after_create :create_store_orders_and_set_cart_items

  def create_stripe_customer_token
    if stripe_card_token.present?
      customer = Stripe::Customer.create(description: user.email, card: stripe_card_token)
      self.user.update(stripe_customer_token: customer.id)
    end
  rescue Stripe::InvalidRequestError => e
    errors[:stripe_card_token] << "Stripe error while creating customer: #{e.message}"
    logger.error "Stripe error while creating customer: #{e.message}"
    false
  end

  def create_store_orders_and_set_cart_items
    self.user.cart_stores.each do |store|
      if store.cart_items.by_user_id(user.id).in_cart.any?
        store_order = self.store_orders.build(store: store)
        store_order.cart_items = store.cart_items.by_user_id(user.id).in_cart
        store_order.save

        store.cart_items.by_user_id(user.id).in_cart.each do |cart_item|
          cart_item.status = :processed
          cart_item.order = self
          cart_item.save
        end

        StoreOrderWorker.perform_async(store_order.id)
      end
    end

    OrderWorker.perform_async(self.id)
  end

  def cal_total
    unless total.present?
      self.total = cal_subtotal + cal_total_shipping + cal_tax_total
    end

    total
  end

  def cal_subtotal
    unless subtotal.present?
      self.subtotal = store_orders.map(&:cal_subtotal).sum
    end

    subtotal
  end

  def cal_total_shipping
    unless total_shipping.present?
      self.total_shipping = store_orders.map(&:cal_total_shipping).sum
    end

    total_shipping
  end

  def cal_tax_total
    unless tax_total.present?
      self.tax_total = store_orders.map(&:cal_tax_total).sum
    end

    tax_total
  end


  def cal_fee
    unless fee.present?
      self.fee = cal_total * 0.04
    end
    
    fee
  end

 def charge 
    begin
      result = Stripe::Charge.create(
          :amount => (cal_fee * 100).to_i,
          :currency => "cad",
          :customer => user.stripe_customer_token,
          :receipt_email => user.email, 
          :metadata => { "order_id" => id })
      
      self.stripe_charge_id = result.id
      self.status = :processed
      self.save
    rescue Stripe::CardError => e
      self.payment_status = e.message
      self.status = failure
      self.save
    end
  end
end