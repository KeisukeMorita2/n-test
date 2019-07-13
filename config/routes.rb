Rails.application.routes.draw do
  root to: 'toppages#index'
  resources :users, only: [:index, :show, :new, :create, :destroy, :edit, :update]
  resources :sessions, only: [:new, :create, :destroy]
  delete 'logout', to: 'sessions#destroy'
end
