Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  get 'broadcast', to: 'broadcast#index'
  get 'broadcast/:authorId/:uuid', to: 'broadcast#show'



  resources :users
  post '/auth/login', to: 'authentication#login'
  root "broadcast#index"
end
