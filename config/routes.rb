Rails.application.routes.draw do
  root 'home#index'
  
  resources :products, only: [:show]
  resources :orders, only: [:index, :show, :destroy]
  resources :checkouts, only: [:new, :create]
  
  # Carrinho
  get 'cart', to: 'carts#show', as: 'cart'
  post 'cart/add/:id', to: 'carts#add', as: 'add_to_cart'
  delete 'cart/remove/:id', to: 'carts#remove', as: 'remove_from_cart'
  
  devise_for :users
end
