Rails.application.routes.draw do
  devise_for :users
  mount RailsAdmin::Engine => '/pbadmin', as: 'rails_admin'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root "products#index"

  resources :products

  resources :cart_items

  resources :orders

  resources :categories, param: :category_id do
    member do
      get :products

      resources :subcategories, param: :subcategory_id do
        member do
          get :products
        end
      end
    end
  end
end
