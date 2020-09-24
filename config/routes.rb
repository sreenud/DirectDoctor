Rails.application.routes.draw do
  devise_for :users
  root 'home#index'

  resources :blogs, only: [:index, :show]
  resources :surveys, only: [:index, :create]
  draw :admin
end
