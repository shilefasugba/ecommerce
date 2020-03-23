class ProductsController < ApplicationController
  before_action :set_collection
  before_action :set_product, only: [:edit, :update, :destroy]
  
  def index
    @products = @collection.by_created_at

    respond_to do |format|
      format.html
      format.csv { send_data @collection.to_csv }
    end
  end

  def new
    @product = @collection.new
  end

  def create
    @product = @store.products.create(product_params)

    if @product.valid?
      redirect_to store_products_path(@store), notice: 'Created success.'
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @product.update(product_params)
      redirect_to store_products_path(@store), notice: 'Updated success.'
    else
      render 'edit'
    end
  end

  def destroy
    @product.destroy

    redirect_to store_products_path(@store), notice: 'Deleted success.'
  end
  
  private 

  def set_product
    @product = @collection.where(slug: params[:id]).first
  end

  def set_collection
    @store = current_user.stores.find(params[:store_id]) if params[:store_id].present?
    @collection = params[:store_id].present? ? @store.products : Product
  end

  def product_params
    params.require(:product).permit(:title, :description, :category_id, :track_inventory, :stock_count, :shipping_weight_lbs,
                 :price, :stripe_id, :sku, :image_urls_raw, :slug, :tax, :user_id, shipping_profile_ids: [])
  end
end