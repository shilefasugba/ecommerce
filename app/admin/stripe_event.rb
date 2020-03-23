ActiveAdmin.register StripeWebhookEvent do
  menu label: 'Stripe'

  index title: 'Stripe' do
    selectable_column
    id_column

    column :order do |item|
      link_to 'Record', item.order.present? ? admin_order_path(item.order) : admin_store_order_path(item.store_order)
    end

    column :stripe_type
    column :stripe_failure_code
    column :created_at
    actions
  end

  show do
    attributes_table do
      row :id
      row :order do |item|
        link_to 'Record', item.order.present? ? admin_order_path(item.order) : admin_store_order_path(item.store_order)
      end
      
      row :data do |item|
        debug item.data
      end

      row :stripe_type
      row :stripe_failure_code
      row :created_at
    end
  end
end