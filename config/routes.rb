Rails.application.routes.draw do
  resources :items
  get '/logout', to: 'items#logout'
  get '/register', to: 'items#register'
  get '/product', to: 'items#product'
  root 'items#mypage'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
