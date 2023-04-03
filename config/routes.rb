Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  get 'broadcast', to: 'broadcast#index'
  get 'broadcast/:uuid', to: 'broadcast#show'

  post 'authenticate', to: 'authentication#authenticate'

  root "broadcast#index"
end
