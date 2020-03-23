class Country < ActiveRecord::Base
  validates :name, presence: true

  has_many :state_provinces
end