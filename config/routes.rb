Rails.application.routes.draw do
  # you can add a conditional to only show this route to admins
  mount RailsAdmin::Engine => "/admin", as: "rails_admin"

  root "pages#home"
  get "home" => "pages#home"
  devise_for :users

  resources :matches do
    resources :messages
  end



  put "/matches/:username/like", to: "matches#like", as: "like_match_by_username"

  put "/matches/:username/reject", to: "matches#reject", as: "reject_match_by_username"

   get "users/:username/messages", to: "users#messages", as: :user_messages

   get "/:username", to: "users#show", as: :user

  resources :users do
    collection do
      get "discover", to: "users#index", as: :discover_users
    end
  end

end
