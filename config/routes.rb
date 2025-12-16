Rails.application.routes.draw do
  devise_for :users
  
  root "home#index"
  
  # Profile routes
  get 'complete_profile', to: 'profiles#complete_profile', as: :complete_profile
  patch 'update_profile', to: 'profiles#update_profile', as: :update_profile
  
  resources :products, only: [:index, :show]
  resources :orders, only: [:index, :show, :new, :create]
  
  namespace :admin do
    root "dashboard#index"
    resources :products
    resources :categories
    resources :orders, only: [:index, :show, :update]
    resources :promotions
    resources :users, only: [:index, :edit, :update] do
      member do
        patch :confirm_email
        patch :verify_phone
      end
    end
  end
  
  get "up" => "rails/health#show", as: :rails_health_check
end
