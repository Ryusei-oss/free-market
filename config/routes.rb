Rails.application.routes.draw do
  devise_for :users
  resources :items
  get '/logout', to: 'items#logout'
  get '/register', to: 'items#register'
  get '/product', to: 'items#product'
  root 'items#mypage'
end
