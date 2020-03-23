class ShippingProfilesController < ApplicationController
  before_action :set_store
  before_action :set_shipping_profile, only: [:destroy, :edit, :update]

  def index
    @shipping_profiles = @store.shipping_profiles
  end

  def new
    @shipping_profile = @store.shipping_profiles.build
  end

  def create
    @shipping_profile = @store.shipping_profiles.create(shipping_profile_params)

    if @shipping_profile.valid?
      redirect_to store_shipping_profiles_path(@store), notice: 'Shipping profile successfully created.'
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @shipping_profile.update(shipping_profile_params)
      redirect_to store_shipping_profiles_path(@store), notice: 'Shipping profile successfully updated.'
    else
      render 'edit'
    end
  end

  def destroy
    @shipping_profile.destroy
    redirect_to store_shipping_profiles_path(@store), notice: 'Shipping profile successfully deleted.'
  end


  private

  def set_shipping_profile
    @shipping_profile = @store.shipping_profiles.find(params[:id])
  end

  def set_store
    @store = current_user.stores.find(params[:store_id])
  end

  def shipping_profile_params
    params.require(:shipping_profile).permit(:shipping_type, :country_id, :all_countries, :base_price, 
                 :per_item, :extra_item)
  end
end
