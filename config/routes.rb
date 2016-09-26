Rails.application.routes.draw do
  resources :tweets, only: [:new, :create, :index]
  resources :rewards, only: [:index, :show] do
    post 'redeem', on: :member
  end

  # Authentication
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  get '/signup', to: 'users#new'
  post '/users', to: 'users#create'

  # Root
  root 'tweets#index'
end
