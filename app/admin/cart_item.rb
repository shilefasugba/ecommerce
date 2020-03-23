ActiveAdmin.register CartItem do
  index do
    selectable_column
    column :id
    column :user
    column :product
    column :shipping_profile
    column :order
    column :count
    column :updated_at
    actions
  end

  form do |f|
    f.inputs do
      f.input :user_id, label: 'User', as: :select, collection: User.all.map { |u| [u.email, u.id] }
      f.input :product_id, label: 'Product', as: :select, collection: Product.all.map { |u| [u.name, u.id] }
      f.input :shipping_profile_id, label: 'Shipping profile', as: :select, collection: ShippingProfile.all.map { |u| [u.id, u.id] }
      f.input :order_id, label: 'Product', as: :select, collection: Order.all.map { |u| [u.id, u.id] }
      f.input :count
    end

    f.actions
  end
  permit_params do
    permitted = [:user_id, :product_id, :count, :order_id, :shipping_profile_id]
    permitted
  end
end
