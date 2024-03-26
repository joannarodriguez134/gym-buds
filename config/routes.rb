Rails.application.routes.draw do

  # Defines the root path route ("/")
  root "matches#index"
  devise_for :users
  
  resources :messages
  resources :matches

 
  get '/:username', to: 'users#show', as: :user


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  
end
