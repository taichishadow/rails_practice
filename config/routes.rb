Rails.application.routes.draw do
  get "/taichishadow", to: "taichishadow#index"
  get "/taichishadow2", to: "taichishadow#index2"
  
  get "/taichishadow/read", to: "taichishadow#read"
  get "/taichishadow/read2", to: "taichishadow#read2"
  post "/taichishadow/create", to: "taichishadow#create"
  delete "/taichishadow/delete", to: "taichishadow#delete"
  get "/taichishadow/detail", to: "taichishadow#detail"
  put "/taichishadow/update", to: "taichishadow#update"
  post "/taichishadow/purchase", to: "taichishadow#purchase"

  namespace :admin do
    get 'book/create'
    get 'book/read'
    get 'book/update'
    get 'book/delete'
  end
  get 'admin' => 'admin#index'

  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end

  resources :users
  resources :orders
  resources :line_items
  resources :carts
  get 'store/index'
  #root 'store#index', as: 'store_index'
  resources :products do
    get :who_bought, on: :member
  end

  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #get "/product", to: "products#index"
  #get "/products", to: "products#show"
  #get "/products/new", to: "products#new"
end
