class Store < ActiveRecord::Base
  include Scopes
  
  belongs_to :user

  validates :name, presence: true
  validates :summary, presence: true
  validates :stripe_id, presence: true
  validates :shipping_profiles, length: { minimum: 1 }
  
  has_many :products
  has_many :shipping_profiles
  has_many :cart_items
  has_many :store_orders
  
  accepts_nested_attributes_for :shipping_profiles, allow_destroy: true

end
