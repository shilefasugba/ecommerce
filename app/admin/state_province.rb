ActiveAdmin.register StateProvince do

   index do
    selectable_column
    column :id
    column :name
    column :country
    column :updated_at
    actions
  end

  permit_params do
    permitted = [:name, :country_id]
    
    permitted
  end
end
