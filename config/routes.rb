Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: "users/sessions",
    passwords: "users/passwords",
    registrations: "users/registrations"
  }

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
    resources :categories, except: %i(new create) do
      member do
        get "new", to: "categories#new", as: :new
        post "new", to: "categories#create", as: :create
      end
      resources :products
    end

    get :import_product, to: "products#import", as: :product_import
    post :import_product, to: "products#import_process", as: :product_import_process

    resources :charts, only: :index
  end
end
