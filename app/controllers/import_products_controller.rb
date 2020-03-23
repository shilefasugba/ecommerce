class ImportProductsController < ApplicationController
  before_action :set_store

  def new
  end

  def create
    @errors = Product.import(params[:file], @store)

    if params[:file].nil? || @errors.any?
      render 'new'
    else
      redirect_to store_products_path(@store), notice: "Products imported."
    end
  end

  private

  def set_store
    @store = current_user.stores.find(params[:store_id])
  end
end
