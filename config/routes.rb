Rails.application.routes.draw do
  devise_for :users

  authenticated :user do
    root to: 'pages#dashboard', as: :authenticated_root
  end

  root to: 'pages#home'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users do
    resources :friendships, only: [ :create ]
  end
  get 'dashboard', to: 'pages#dashboard', as: 'dashboard'
  get 'users/:id' => 'users#show', as: "user_profile"
  get 'friends', to: 'users#friends', as: 'friends'
end
