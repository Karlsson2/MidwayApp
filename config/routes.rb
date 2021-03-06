Rails.application.routes.draw do
  devise_for :users


  root to: 'pages#home'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users do
    resources :friendships, only: [ :create ]
  end



  resources :midways, only: [:index, :new, :create, :edit, :update, :show]

  get 'dashboard', to: 'pages#dashboard', as: 'dashboard'
  get 'users/:id' => 'users#show', as: "user_profile"
  get 'friends', to: 'users#friends', as: 'friends'
  get 'choose_venue', to: 'midways#choose_venue', as: 'choose_venue'
  get 'my_midways', to: 'midways#my_midways', as: 'my_midways'
  patch 'accept_request/:id', to: 'friendships#friendship_confirm', as: 'accept'
  patch 'decline_request/:id', to: 'friendships#friendship_decline', as: 'decline'
end
