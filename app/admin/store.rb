ActiveAdmin.register Store do

  index do
    selectable_column
    column :id
    column :name
    column :summary
    column :stripe_id
    column :user
    column 'Products' do |store|
      link_to store.products.count, admin_store_products_path(store)
    end

    column 'Shipping profiles' do |store|
      link_to store.shipping_profiles.count, admin_shipping_profiles_path(store_id: store.id)
    end

    column 'Store Orders' do |store|
      link_to store.store_orders.count, admin_store_orders_path(store_id: store.id)
    end
    
    column :updated_at
    actions
  end

  permit_params do
    permitted = [:name, :summary, :user_id, :stripe_id, shipping_profiles_attributes: [:shipping_type, :base_price, :extra_item, :per_item]]
    permitted
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :summary
      f.input :stripe_id
      f.input :user_id, label: 'User', as: :select, collection: User.all.map { |u| [u.email, u.id] }
    end

    f.inputs do
      f.semantic_errors :shipping_profiles

      f.has_many :shipping_profiles, allow_destroy: true do |shipping_profile|
        #shipping_profile.inputs "Shipping profiles" do
          shipping_profile.input :shipping_type 
          shipping_profile.input :base_price 
          shipping_profile.input :extra_item 
          shipping_profile.input :per_item 
        #end
      end
    end

    f.actions
  end
end
