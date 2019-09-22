Rails.application.routes.draw do
  root to: 'toppages#index'
  resources :users, only: [:index, :show, :new, :create, :destroy, :edit, :update]
  resources :sessions, only: [:new, :create, :destroy]
  resources :questions, only: [:create, :destroy, :index, :new, :show]
end
