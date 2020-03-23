ActiveAdmin.register Address do
  menu false
  form do |f|
    f.inputs do
      f.input :user_id, label: 'User', as: :select, collection: User.all.map { |u| [u.email, u.id] }
      f.input :state_province_id, label: 'State', as: :select, collection: StateProvince.all.map { |u| [u.name, u.id] }

      f.input :address1
      f.input :address2
      f.input :city
      f.input :first_name
      f.input :last_name
      f.input :postal_code
    end

    f.actions
  end

  permit_params do
    permitted = [:user_id, :address1, :address2, :city, :state_province_id, :first_name, :last_name, :postal_code]
    permitted
  end
end
