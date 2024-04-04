Rails.application.routes.draw do

  # Defines the root path route ("/")
  root "users#index"
  get "landing" => "pages#landing"
  devise_for :users

  # message belongs to match
  resources :matches do
    resources :messages
  end
  
# Add a custom route for user messages
get 'users/:id/messages', to: 'users#messages', as: :user_messages
  get '/:username', to: 'users#show', as: :user
  


  resources :users do
    collection do
      get 'discover', to: 'users#index', as: :discover_users
    end
  end


  


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  
end
