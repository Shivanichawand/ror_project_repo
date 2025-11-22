# config/routes.rb
Rails.application.routes.draw do
  post 'signup', to: 'auth#signup'
  post 'login', to: 'auth#login'

  resources :publications
end

