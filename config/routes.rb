Rails.application.routes.draw do

  # Defines the root path route ("/")
  root "pages#home"
  get "home" => "pages#home"
  devise_for :users

  # message belongs to match
  resources :matches do
    resources :messages
  end
  
  

  put '/matches/:username/like', to: 'matches#like', as: 'like_match_by_username'

  put '/matches/:username/reject', to: 'matches#reject', as: 'reject_match_by_username'

   #  custom route for user messages
   get 'users/:username/messages', to: 'users#messages', as: :user_messages
  
   get '/:username', to: 'users#show', as: :user

  resources :users do
    collection do
      get 'discover', to: 'users#index', as: :discover_users
    end
  end

end
