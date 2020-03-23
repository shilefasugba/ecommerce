ActiveAdmin.register Product do
  belongs_to :store

  index do
    selectable_column
    column :id
    column :title
    column :store
    column :category
    column :track_inventory
    column :stock_count
    column :shipping_weight_lbs
    column :price
    column :sku
    column :slug
    column :tax
    column :updated_at
    actions
  end

  controller do
    def find_resource
      begin
        scoped_collection.where(slug: params[:id]).first!
      rescue ActiveRecord::RecordNotFound
        scoped_collection.find(params[:id])
      end
    end
  end

  form do |f|
    f.inputs do
      f.input :title
      f.input :description
      f.input :store_id, label: 'Store', as: :select, collection: Store.all.map { |u| [u.name, u.id] }
      f.input :category_id, label: 'Category', as: :select, collection: Category.all.map { |u| [u.name, u.id] }
      f.input :shipping_profile_ids, label: 'Shipping profiles', as: :select, multiple: true, collection: store.shipping_profiles.all.map { |u| [u.title, u.id] }
      f.input :track_inventory
      f.input :stock_count
      f.input :shipping_weight_lbs
      f.input :price
      f.input :sku
      f.input :slug
      f.input :tax

      f.inputs "Image Urls" do
        f.input :image_urls_raw, as: :text
      end
    end

    f.actions
  end

  permit_params do
    permitted = [:title, :description, :store_id, :category_id, :track_inventory, :stock_count, :shipping_weight_lbs,
                 :price, :stripe_id, :sku, :image_urls_raw, :slug, :tax, :user_id, shipping_profile_ids: []]
    permitted
  end
end