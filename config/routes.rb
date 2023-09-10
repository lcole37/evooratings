Rails.application.routes.draw do
  root to: 'landing_page#index'
  #
  get '/login', to: 'users#login_form'
  post '/login', to: 'users#login_user'
  get '/register', to: 'users#new'
  post '/register', to: 'users#create'
  # get '/user', to: 'users#show'
  #
  resources :users, only: [:show, :new] #do
  #   resources :favorites, only: [:index]
  #   resources :reviews, only: [:index]
  # end
  #
  # get '/user_favorites_index', to: 'users#'
  delete '/logout', to: "users#logout_user"

end
