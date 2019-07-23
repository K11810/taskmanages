Rails.application.routes.draw do

  root 'tasks#index'

  resources :users, only: [:new, :create, :show]
  resources :sessions, only: [:new, :create, :destroy]

  resources :tasks do
    collection do
      post :confirm
    end
  end
end
