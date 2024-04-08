Rails.application.routes.draw do

  # Defines the root path route ("/")
  root "users#index"
  get "landing" => "pages#landing"
  devise_for :users

  # message belongs to match
  resources :matches do
    resources :messages
    member do
      put 'like'
      put 'reject'
    end
  end
  
  #  custom route for user messages

  get '/:username', to: 'users#show', as: :user

  get 'users/:username/messages', to: 'users#messages', as: :user_messages

  # put '/users/:username/like', to: 'users#like', as: 'like_user'
  # put '/users/:username/dislike', to: 'users#dislike', as: 'dislike_user'

  resources :users do
    collection do
      get 'discover', to: 'users#index', as: :discover_users
    end
  end
  
end
