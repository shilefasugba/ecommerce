class StoreOrder < ActiveRecord::Base
  enum status: [:unprocessed, :processed, :failure, :success]

  belongs_to :store
  belongs_to :order

  has_many :cart_items
  has_many :stripe_webhook_events

  validates :total, :total_shipping, :store_id, :subtotal, :tax_total, presence: true, unless: :unprocessed?
  
  def processed?
    status == 'processed'
  end

  def cal_total
    unless self.total.present?
      self.total = cal_subtotal + cal_total_shipping + cal_tax_total
    end

    total
  end

  def cal_subtotal
    unless subtotal.present?
      self.subtotal = 0.0
      
      cart_items.each do |cart_item|
        self.subtotal += cart_item.count * cart_item.product.price
      end
    end

    subtotal
  end

  def cal_total_shipping
    unless total_shipping.present?
      self.total_shipping = 0.0
      
      cart_items.each do |cart_item|
        shipping_profile = cart_item.shipping_profile

        if shipping_profile.shipping_type == 'flat'
          self.total_shipping += shipping_profile.base_price
        elsif shipping_profile.shipping_type == 'flat_and_extra_items'
          self.total_shipping += shipping_profile.base_price + shipping_profile.extra_tem * cart_item.count
        else shipping_profile.shipping_type == 'per_item'
          self.total_shipping += shipping_profile.per_item * cart_item.count
        end
      end
    end

    total_shipping
  end

  def cal_tax_total
    unless tax_total.present?
      self.tax_total = 0.0

      cart_items.each do |cart_item|
        self.tax_total += cart_item.count * cart_item.product.tax
      end
    end

    tax_total
  end

  def charge 
    begin
      charge = Stripe::Charge.create(
          :amount => (cal_total * 100).to_i,
          :currency => "cad",
          :customer => order.user.stripe_customer_token,
          :receipt_email => order.user.email, 
          :metadata => {"store_order_id" => id },
          #:destination => store.stripe_id
      )
      
      self.stripe_charge_id = charge.id
      self.status = :processed
      self.save
    rescue Stripe::CardError => e
      self.payment_status = e.message
      self.status = failure
      self.save
    end
  end
end
