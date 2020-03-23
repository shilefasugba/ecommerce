class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :stores
  has_many :orders
  has_many :products
  has_many :addresses
  has_many :cart_items
  
  has_many :cart_stores, through: :cart_items, source: :store
end
