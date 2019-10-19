Rails.application.routes.draw do
  root to: 'toppages#index'
  resources :users, only: [:index, :show, :new, :create, :destroy, :edit, :update] do
    member do
      get :followings
      get :followers
    end
  end
  resources :sessions, only: [:new, :create, :destroy]
  resources :questions, only: [:create, :destroy, :index, :new, :show, :edit, :update]
  resources :relationships, only: [:create, :destroy]
end
