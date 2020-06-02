class CartItem < ActiveRecord::Base
  enum status: [:in_cart, :processed]

  belongs_to :user
  belongs_to :product
  belongs_to :order
  belongs_to :store
  belongs_to :shipping_profile

  has_one :store, through: :product

  validates :store_id, :user_id, :shipping_profile_id, :product_id, presence: true

  scope :by_user_id, -> (user_id) { where(user_id: user_id) }
  scope :by_order_id, -> (order_id) { where(order_id: order_id) }
  scope :unprocessed, -> { where(status: 'unprocessed') }
  scope :in_cart, -> { where(status: 'in_cart') }
end
