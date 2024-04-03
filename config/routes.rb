Rails.application.routes.draw do
  resources :categories, except: :show
  resources :products, path: '/' # ahora /products es igual a /
  # delete 'products/:id', to: 'products#destroy'
  # patch 'products/:id', to: 'products#update'
  # post '/products', to: 'products#create'
  # get '/products/new', to: 'products#new', as: :new_product
  # get '/products', to: 'products#index'
  # get '/products/:id', to: 'products#show', as: :product
  # get '/products/:id/edit', to: 'products#edit', as: :edit_product
  namespace :authentication, path: '', as: '' do # el path: '' es para que no este /authetication, y el as: '' es para no tener que poner authentication_users_new_path porque es muy largo, queremos users_new solo
    resources :users, only: %i[new create]
  end
end
