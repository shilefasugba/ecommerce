ActiveAdmin.register Category do
  index do
    selectable_column
    column :id
    column :name
    column :updated_at
    
    # column 'Products' do |category|
    #   link_to category.products.count, admin_products_path(category_id: category.id)
    # end

    actions
  end

  permit_params do
    permitted = [:name]
    permitted
  end
end
