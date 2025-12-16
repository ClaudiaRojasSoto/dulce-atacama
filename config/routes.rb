Rails.application.routes.draw do
  devise_for :users
  
  root "home#index"
  
  resources :products, only: [:index, :show]
  resources :orders, only: [:index, :show, :new, :create]
  
  namespace :admin do
    root "dashboard#index"
    resources :products
    resources :categories
    resources :orders, only: [:index, :show, :update]
    resources :promotions
  end
  
  get "up" => "rails/health#show", as: :rails_health_check
end
