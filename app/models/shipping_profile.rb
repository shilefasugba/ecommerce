class ShippingProfile < ActiveRecord::Base 
  enum shipping_type: [:flat, :flat_and_extra_items, :per_item]

  belongs_to :country
  belongs_to :product
  belongs_to :store
  has_many :cart_items

  validates :shipping_type, presence: true
  validates :base_price, presence: true
  validates :extra_item, presence: true
  validates :per_item, presence: true

  def title 
    result = shipping_type.humanize + ':'

    if shipping_type == 'flat'
      result += base_price.to_s
    elsif shipping_type == 'flat_and_extra_items'
      result += base_price.to_s + '|' + extra_item.to_s
    else
      result += per_item.to_s
    end
    
    result
  end
end
