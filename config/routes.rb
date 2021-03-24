Rails.application.routes.draw do
  get 'sessions/new'
  root 'static_pages#home'
  get '/about', to:"static_pages#about"
  get '/signup', to:"users#new"
  get '/login', to:"sessions#new"
  delete '/logout', to:'sessions#destroy'
  resources :users
  resources :sessions, only:[:new, :create]
end
