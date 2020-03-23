class Address < ActiveRecord::Base
  belongs_to :user
  belongs_to :state_province

  validates :address1, presence: true
  validates :city, presence: true
  validates :state_province_id, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :user_id, presence: true
  validates :postal_code, presence: true

end