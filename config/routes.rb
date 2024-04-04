Rails.application.routes.draw do

  # Defines the root path route ("/")
  root "users#index"
  get "landing" => "pages#landing"
  devise_for :users

  # message belongs to match
  resources :matches do
    resources :messages
  end
  
  #  custom route for user messages

  get '/:username', to: 'users#show', as: :user

  get 'users/:username/messages', to: 'users#messages', as: :user_messages
  


  resources :users do
    collection do
      get 'discover', to: 'users#index', as: :discover_users
    end
  end


  


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  
end
