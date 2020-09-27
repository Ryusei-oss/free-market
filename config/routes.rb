Rails.application.routes.draw do
  devise_for :users
  #resources :products, only: :show
  resources :items 
  resources :users, only: :show do
    resources :addresses
    #resources :products, except: :show
  end
  root to: 'items#index'
  get '/registrations', to: 'items#registrations'
  get '/sessions', to: 'items#sessions'
  get 'logout', to: 'users#logout'
  get '/register', to: 'items#register'
  

  resources :products do
    get '/purchase', to: 'items#purchase'
    post '/sold', to: 'items#sold'
    collection do
      get 'category_children', defaults: { format: 'json' }
      get 'category_grandchildren', defaults: { format: 'json' }
    end
    member do
      get 'category_children', defaults: { format: 'json' }
      get 'category_grandchildren', defaults: { format: 'json' }
    end
  end

  resources :cards, only: [:index, :new, :create, :destroy] 
    resources :posts do 
      collection do 
        post 'pay/:id'=>   'posts#pay' 
    end 
  end

end
