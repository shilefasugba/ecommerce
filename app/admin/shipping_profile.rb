ActiveAdmin.register ShippingProfile do
  menu false
  
  index do
    selectable_column
    column :id
    column :shipping_option_type
    column :country
    column 'Cart Items' do |shipping_profile|
      link_to shipping_profile.cart_items.count, admin_cart_items_path(shipping_profile_id: shipping_profile.id)
    end
    column :all_countries
    column :base_price
    column :per_item
    column :extra_item
    column :updated_at
    actions
  end

  permit_params do
    permitted = [:shipping_option_type_id, :country_id, :all_countries, :base_price, 
                 :per_item, :extra_item]
    permitted
  end


end