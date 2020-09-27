Rails.application.routes.draw do
  devise_for :users
  root 'home#index'

  resources :blogs, only: [:index, :show]
  resources :surveys, only: [:index, :create]
  mount Shrine.upload_endpoint(:cache) => "/images/upload"
  mount ProfilePicUploader.derivation_endpoint => "/derivations/image"

  draw :admin
end
