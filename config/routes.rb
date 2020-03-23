require 'sidekiq/web'

Rails.application.routes.draw do  
  
  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web, at: '/sidekiq'
  end

  ActiveAdmin.routes(self)
  devise_for :users
  mount StripeEvent::Engine, at: '/stripe-events'
  root 'products#index'

  resources :products, :orders, :cart_items
  
  resources :stores do
    resources :store_orders do
      member do
        get :run_process
      end
    end

    resources :products, :cart_items, :shipping_profiles
    
    resource :import_products
  end
end