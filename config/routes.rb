Rails.application.routes.draw do
  root to: "home#index"

  get :login, to: "sessions#new"
  post :login, to: "sessions#create"
  delete :logout, to: "sessions#destroy"
  get :cart, to: "cart#index"
  post "products/:product_id/rating", to: "rates#rating", as: :product_rating
  get "add_cart/:id_product", to: "sessions#add_cart", as: :add_cart
  get "remove_cart/:id_product", to: "sessions#remove_cart", as: :remove_cart
  put "update_cart", to: "sessions#update_cart", as: :update_cart
  put "update_hard_cart", to: "sessions#update_hard_cart", as: :update_hard_cart

  resources :orders, only: %i(index create)
  resources :products, only: %i(index show)
  resources :categories, only: :show
  namespace :admin do
    resources :orders, only: %i(index show) do
      member do
        patch :approve
        patch :reject
      end
    end
  end
end
