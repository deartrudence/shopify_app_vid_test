Rails.application.routes.draw do
  resources :stored_products
  root :to => 'home#index'
  mount ShopifyApp::Engine, at: '/'

  get 'home/index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
