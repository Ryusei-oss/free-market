Rails.application.routes.draw do
  devise_for :users
  resources :items
  resources :users, only: :show do
    resources :addresses
  end
  root to: 'items#index'
  get '/registrations', to: 'items#registrations'
  get '/sessions', to: 'items#sessions'
  get 'logout', to: 'users#logout'
  get '/register', to: 'items#register'
  get '/product', to: 'items#product'
  get '/purchase', to: 'items#purchase'
  get '/new', to: 'items#new'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
