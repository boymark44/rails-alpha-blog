Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  #get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  # The root route
  root 'pages#home'

  # The about route
  get 'about', to: 'pages#about'

  # The RESTful routes for articles
  resources :articles  #, only: [:show, :index, :new, :create, :edit, :update, :destroy]

  # The RESTful routes for users
  get 'signup', to: 'users#new'
  resources :users, except: [:new]

  # The RESTful routes for sessions
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy', as: :logout

end
