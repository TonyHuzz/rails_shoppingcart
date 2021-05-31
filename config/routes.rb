Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    confirmations: 'users/confirmations',
    passwords: 'users/passwords',
    omniauth_callbacks: 'users/omniauth_callbacks',
    unlocks: 'users/unlocks'
  }

  mount RailsAdmin::Engine => '/pbadmin', as: 'rails_admin'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root "products#index"

  resources :products

  resources :cart_items

  resources :orders

  resources :payments

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
