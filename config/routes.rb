Rails.application.routes.draw do
  # PONEMOS PRIMERO LAS RUTAS DE USER Y SESSION PORQUE ESTABA TENIENDO CONFLICTO CON LAS RUTAS DE PRODUCT
  namespace :authentication, path: '', as: '' do # el path: '' es para que no este /authetication, y el as: '' es para no tener que poner authentication_users_new_path porque es muy largo, queremos users_new solo
    resources :users, only: %i[new create], path: '/register', path_names: { new: '/' }
    resources :sessions, only: %i[create destroy] # , path: '/login', path_names: { new: '/' } quitamos esto y quitamos metodo new porque ahora estara en el mismoq que new user
  end

  resources :favorites, only: %i[index create destroy], param: :product_id # Asi el param id de siempre pasara a llamarse product_id es mejor y se entiende mejor, en el controlador de favorites buscaremos product por el param pasado al invocar un metodo del controlador favorites y el param será llamado product_id porq aca lo definimos asi, id es de default pero le cambiamos el nombre a product_id
  # ESTE SEGUNDO RESOURCES DE USERS VA AFUERA EL PRIMERO PORQUE EL PRIMERO SE DEDICA UNICAMENTE AUTENTICACION
  resources :users, only: %i[show edit update], path: '/user', param: :username # Asi el nombre del param sera username y no id, porque queremos buscar por username y no id
  resources :categories, except: :show
  resources :products, path: '/' # ahora /products es igual a /
  # delete 'products/:id', to: 'products#destroy'
  # patch 'products/:id', to: 'products#update'
  # post '/products', to: 'products#create'
  # get '/products/new', to: 'products#new', as: :new_product
  # get '/products', to: 'products#index'
  # get '/products/:id', to: 'products#show', as: :product
  # get '/products/:id/edit', to: 'products#edit', as: :edit_product
end
