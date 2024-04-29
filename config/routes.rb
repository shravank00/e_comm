Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  root to: 'products#index'
  resources :users
  resources :products
  resources :carts, only: [:show, :destroy]
  resources :cart_items, only: [:create, :show, :destroy]
  post 'cart_items/:id/add', to: 'cart_items#add_quantity', as: 'cart_item_add'
  post 'cart_items/:id/reduce', to: 'cart_items#reduce_quantity', as: 'cart_item_reduce'

  resources :orders
end
