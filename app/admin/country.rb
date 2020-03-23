ActiveAdmin.register Country do

  index do
    selectable_column
    column :id
    column :name

    column 'States' do |country|
      link_to country.state_provinces.count, admin_state_provinces_path(country_id: country.id)
    end
    
    column :updated_at
    actions
  end

  permit_params do
    permitted = [:name]
    permitted
  end
end
