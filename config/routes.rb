Rails.application.routes.draw do
  devise_for :admins
  root "homes#index"
  resources :homes
  namespace :admins do
    resources :fish do
      member do
        delete :delete_image
      end
    end
    resources :categories do
      resources :fish_categories
    end
    namespace :fish do
      post 'csv_upload'
    end
  end

end
