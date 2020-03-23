class ChangesProductImagesType < ActiveRecord::Migration
  def up
    add_column :products, :image_urls, :text, array: true, default: []
    remove_column :products, :images
  end

  def down
    remove_column :products, :image_urls
    add_column :products, :images, :string
  end
end
