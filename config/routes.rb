Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  filter :locale

  root 'main#index'

  scope module: 'home' do
    resources :user_sessions, only: [:new, :create]
    resources :users, only: [:new, :create]
    get 'login' => 'user_sessions#new', :as => :login

    post 'oauth/callback' => 'oauths#callback'
    get 'oauth/callback' => 'oauths#callback'
    get 'oauth/:provider' => 'oauths#oauth', as: :auth_at_provider
  end

  scope module: 'dashboard' do
    resources :user_sessions, only: :destroy
    resources :users, only: :destroy
    post 'logout' => 'user_sessions#destroy', :as => :logout
    get 'logout' => 'user_sessions#destroy'

    resources :cards
    match 'search-photo', to: 'cards#search_photo', via: [:patch, :post]
    get 'remote' => 'cards#remote'
    post 'remote_create' => 'cards#remote_create'

    resources :blocks do
      member do
        put 'set_as_current'
        put 'reset_as_current'
      end
    end

    # get 'remote_cards' => 'remote_cards#new'

    put 'review_card' => 'trainer#review_card'
    get 'trainer' => 'trainer#index'

    get 'profile/:id/edit' => 'profile#edit', as: :edit_profile
    put 'profile/:id' => 'profile#update', as: :profile
  end
end
