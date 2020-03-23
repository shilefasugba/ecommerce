class StateProvince < ActiveRecord::Base
  validates :name, presence: true
  validates :country_id, presence: true

  belongs_to :country
end