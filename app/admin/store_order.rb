ActiveAdmin.register StoreOrder do
   index do
    selectable_column
    column :id
    column :store
    column :stripe_charge_id
    column :status
    
    column 'Cart' do |order|
      link_to order.cart_items.count, admin_cart_items_path(store_order_id: order.id)
    end

    column 'Stripe events' do |order|
      link_to order.stripe_webhook_events.count, admin_stripe_webhook_events_path(store_order_id: order.id)
    end

    column :tax_total
    column :subtotal
    column :payment_status_id
    column :total_shipping
    column :total
    column :updated_at
    actions
  end

  form do |f|
    f.inputs do
      f.input :user_id, label: 'User', as: :select, collection: User.all.map { |u| [u.email, u.id] }
      f.input :billing_address_id, label: 'Billing address', as: :select, collection: Address.all.map { |u| [u.address1, u.id] }
      f.input :shipping_address_id, label: 'Shipping address', as: :select, collection: Address.all.map { |u| [u.address1, u.id] }
      f.input :store_id, label: 'Store', as: :select, collection: Store.all.map { |u| [u.name, u.id] }
      f.input :total
      f.input :total_shipping
      f.input :payment_status_id
      f.input :subtotal
      f.input :tax_total
      f.input :stripe_charge_id
    end

    f.actions
  end

  permit_params do
    permitted = [:user_id, :total, :total_shipping, :payment_status_id, :store_id, :subtotal, 
                 :tax_total, :stripe_charge_id, :billing_address_id, :shipping_address_id]
    
    permitted
  end
end

