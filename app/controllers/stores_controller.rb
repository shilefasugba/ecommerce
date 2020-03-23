class StoresController < ApplicationController
  def index
    @stores = current_user.stores.by_created_at
  end

  def show
    @store = current_user.stores.find(params[:id])
  end
end