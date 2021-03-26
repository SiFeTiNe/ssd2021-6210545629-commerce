Rails.application.routes.draw do
  devise_for :admins
  get 'test_products/index'
  root 'products#index'
  #
  # get '/welcomes', to: 'welcomes#index'
  # get '/products', to: 'products#index'

  resources :test_products, only: :index
end
