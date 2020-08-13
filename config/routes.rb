Rails.application.routes.draw do
  root 'items#mypage'
  get '/items/logout', to: 'items#logout'
  get '/items/register', to: 'items#register'
  resources :items
  root 'items#new'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
