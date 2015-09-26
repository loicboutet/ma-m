Rails.application.routes.draw do
  resources :ratings
  root to: 'visitors#index'
  devise_for :users
  resources :users
  resources :shops
end
