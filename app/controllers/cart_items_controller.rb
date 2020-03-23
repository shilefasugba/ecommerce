class CartItemsController < ApplicationController
  before_action :set_collection
  
  def index
    @stores = current_user.cart_stores.uniq
  end

  def new
    @cart_item = current_user.cart_items.where(product_id: params[:product_id], status: 'in_cart').first_or_initialize
    
    if @cart_item.new_record?
      render 'new'
    else
      redirect_to edit_cart_item_path(@cart_item)
    end
  end

  def edit
    @cart_item = current_user.cart_items.find(params[:id])
  end

  def update
    @cart_item = current_user.cart_items.find(params[:id])

    if @cart_item.update(cart_item_params)
      redirect_to products_path, notice: 'Added to the cart.'
    else
      render 'edit'
    end
  end

  def create
    @cart_item = @collection.new(cart_item_params)
    @cart_item.user = current_user 

    if @cart_item.save
      redirect_to products_path, notice: 'Added to the cart.'
    else
      render 'new'
    end
  end

  def set_collection
    @collection = params[:store_id].present? ? Store.find(params[:store_id]).cart_items : current_user.cart_items
  end

  def destroy
    @cart_item = current_user.cart_items.find(params[:id])
    @cart_item.destroy
    redirect_to cart_items_path, notice: 'Removed from the cart.'
  end

  protected

  def cart_item_params
    params.require(:cart_item).permit(:product_id, :count, :shipping_profile_id)
  end
end