Rails.application.routes.draw do
  devise_for :users
  root 'homes#index'
  resources :homes do
    match '/create_order' => 'homes#create_order', via: [:get, :post]
  end
  resources :orders
  namespace :users do
    resources :products do
      member do
        delete :delete_image
      end
    end
    resources :categories do
      resources :product_categories
    end
    namespace :products do
      post 'csv_upload'
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

