class StoreOrdersController < ApplicationController
  before_action :set_store
  
  def index
    @store_orders = @store.store_orders
  end
  
  def run_process
    @store_order = @store.store_orders.find(params[:id])
    StoreOrderWorker.new.perform(params[:id])

    redirect_to store_store_orders_path(@store), notice: 'Process was runed'
  end

  private
  
  def set_store
    @store = current_user.stores.find(params[:store_id])
  end
end