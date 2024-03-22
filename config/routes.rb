Rails.application.routes.draw do

  # Defines the root path route ("/")
  root "messages#index"
  devise_for :users
  
  resources :messages
  resources :matches

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  
end
