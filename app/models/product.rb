require 'csv'

class Product < ActiveRecord::Base
  include Scopes

  attr_accessor :store_name, :category_name, :shipping_profile_types, :names_raw

  belongs_to :user
  belongs_to :store
  belongs_to :category
  has_many :shipping_profiles
  
  validates :shipping_profiles, length: { minimum: 1 }
  validates :image_urls, length: { maximum: 5 }
  validates :title, :description, :store_id, :category_id, :stock_count, :shipping_weight_lbs, :price, :sku, :tax, presence: true
  validates :slug, presence: true, uniqueness: true

  before_validation :set_fields

  def set_fields
    self.store = Store.where(name: store_name).first if store_name.present? && store.nil?
    self.shipping_profiles << store.shipping_profiles.where(shipping_type: shipping_profile_types.split(',')).first if shipping_profile_types.present? && shipping_profiles.empty?
    self.category = Category.where(name: category_name).first if category_name.present? && category.nil?
  end

  def image_urls_raw
    self.image_urls.join("\n") unless self.image_urls.nil?
  end

  def image_urls_raw=(values)
    self.image_urls = []
    self.image_urls=values.split("\n")
  end

  def to_param
    slug
  end

  def shipping_profile_types
    shipping_profiles.map { |s| s.shipping_type }.join(', ')
  end

  def shipping_profile_types=(values)
    self.shipping_profiles = store.shipping_profiles.where(shipping_type: values.split(','))
  end

  def category_name
    category.name
  end

  def category_name=(value)
    self.category = Category.where(name: value).first
  end

  def store_name
    store.name
  end

  def self.to_csv
    attributes = %w{id title description store_name category_name track_inventory 
                    stock_count shipping_weight_lbs price sku image_urls_raw slug tax shipping_profile_types}

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |user|
        csv << attributes.map{ |attr| user.send(attr) }
      end
    end
  end

  def self.import(file, store)
    csv = CSV.parse(file.read, :headers => true)
    errors = []

    csv.each_with_index do |row, index|
      p = store.products.create(row.to_hash)
      errors[index] = p.errors unless p.valid?
    end

    errors
  end
end
