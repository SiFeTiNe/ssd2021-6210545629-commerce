Rails.application.routes.draw do
  devise_for :admins
  root "homes#index"
  resources :homes
  namespace :admins do
    resources :item do
      member do
        delete :delete_image
      end
    end
    resources :categories do
      resources :item_categories
    end
    namespace :item do
      post 'csv_upload'
    end
  end

end
