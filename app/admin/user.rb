ActiveAdmin.register User do

  index do
    selectable_column
    column :id
    column :email
    column :updated_at
    column :admin
    column 'Cart' do |user|
      link_to user.cart_items.count, admin_cart_items_path(user_id: user.id)
    end

    column 'Products' do |user|
      link_to user.products.count, admin_products_path(user_id: user.id)
    end

    column 'Orders' do |user|
      link_to user.orders.count, admin_orders_path(user_id: user.id)
    end

    column 'Store' do |user|
      link_to user.stores.count, admin_stores_path(user_id: user.id)
    end

    column 'Addresses' do |user|
      link_to user.addresses.count, admin_addresses_path(user_id: user.id)
    end

    actions
  end

  permit_params do
    permitted = [:email, :password, :password_confirmation, :admin]
    permitted
  end

end
