Rails.application.routes.draw do
  root to: "home#index"

  get :login, to: "sessions#new"
  post :login, to: "sessions#create"
  delete :logout, to: "sessions#destroy"
  get :cart, to: "cart#index"
  get "add_cart/:id_product", to: "sessions#add_cart", as: :add_cart
  get "remove_cart/:id_product", to: "sessions#remove_cart", as: :remove_cart
  put "update_cart", to: "sessions#update_cart", as: :update_cart

  resources :orders, only: %i(index create)
end
