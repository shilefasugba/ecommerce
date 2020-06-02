class Address < ActiveRecord::Base
  belongs_to :user
  belongs_to :state_province

  validates :address1, :city, :state_province, :first_name, :last_name, :user_id, :postal_code, presence: true
end
