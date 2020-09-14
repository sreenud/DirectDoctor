Rails.application.routes.draw do
  devise_for :users
  root 'home#index'

  resources :blog, only: [:index, :show]
  draw :admin
end
