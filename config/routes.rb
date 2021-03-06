Rails.application.routes.draw do

  root 'tasks#index'

  resources :tasks do
    collection do
      post :confirm
    end
  end

  resources :users, only: [:new, :create, :show]

  resources :sessions, only: [:new, :create, :destroy]

  resources :labels, only: [:create, :destroy]

  namespace :admin do
    resources :users
  end

end
