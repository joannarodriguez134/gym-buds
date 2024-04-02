Rails.application.routes.draw do

  # Defines the root path route ("/")
  root "users#index"
  devise_for :users
  
  resources :messages
  resources :matches

  get '/:username', to: 'users#show', as: :user


  resources :users do
    collection do
      get 'discover', to: 'users#index', as: :discover_users
    end
  end


  


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  
end
