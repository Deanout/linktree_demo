# frozen_string_literal: true

Rails.application.routes.draw do
  resources :themes
  # Create routes for /:id for users, but constrain the routes to not be in the list of reserved words
  # (e.g. admin, analytics, appearance, settings, up, etc.)
  get '/:slug', to: 'profiles#show', as: :user

  resources :links, only: %i[create update destroy] do
    patch 'toggle_active', on: :member
  end
  # link_position_path update
  patch '/link_position/:id', to: 'links#update_position', as: :link_position

  devise_for :users
  root 'admin#index'
  get 'admin/index'
  get 'admin/appearance'
  get 'admin/analytics'
  get 'admin/settings'
  patch 'admin/update', to: 'admin#update', as: :admin_update
  # Update theme for profile pages on appearance page
  patch 'admin/update_theme', to: 'admin#update_theme', as: :admin_update_theme

  get 'admin/manage_socials', to: 'admin#manage_socials', as: :admin_manage_socials
  patch 'admin/update_socials', to: 'admin#update_socials', as: :admin_update_socials

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  # root "articles#index"
end
