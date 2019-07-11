Rails.application.routes.draw do
  root to: 'toppages#index'
  resources :users, only: [:index, :show, :new, :create, :destroy]
  resources :sessions, only: [:new, :create, :destroy]
  post 'logout', to: 'sessions#destroy'
end
