class StripeWebhookEvent < ActiveRecord::Base
  belongs_to :order
  belongs_to :store_order
end