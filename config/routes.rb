Rails.application.routes.draw do
  resources :comments
  resources :ratings
  root to: 'maps#index'
  devise_for :users
  resources :users
  resources :shops
  resources :maps
end
