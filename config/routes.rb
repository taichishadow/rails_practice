Rails.application.routes.draw do
  get 'store/index'
  #root 'store#index', as: 'store_index'
  resources :products
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #get "/product", to: "products#index"
  #get "/products", to: "products#show"
  #get "/products/new", to: "products#new"
end
