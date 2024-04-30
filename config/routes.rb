Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  root to: 'products#index'
  resources :users
  resources :products
  resources :carts, only: %i[show destroy]
  resources :cart_items, only: %i[create show destroy]
  post 'cart_items/:id/add', to: 'cart_items#add_quantity', as: 'cart_item_add'
  post 'cart_items/:id/reduce', to: 'cart_items#reduce_quantity', as: 'cart_item_reduce'

  resources :orders

  namespace :api do
    namespace :v1 do
      get '/users', to: 'authentication#users'
      post '/login', to: 'authentication#login'
      post '/signup', to: 'authentication#signup'
      resources :products, only: %i[index show]
      resources :cart_items, only: %i[create destroy]
      resources :orders, only: %i[index create]
    end
  end
end
