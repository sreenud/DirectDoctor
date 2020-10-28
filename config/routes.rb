Rails.application.routes.draw do
  devise_for :users
  root 'home#index'

  get "/*any", to: "redirects#index", constraints: RedirectConstraint.new

  resources :blogs, only: [:index, :show]
  resources :tips, only: [:index]
  get "/blogs/:blog_id/:id", to: "tips#show"

  resources :surveys, only: [:index, :create]
  mount Shrine.upload_endpoint(:cache) => "/images/upload"
  mount ProfilePicUploader.derivation_endpoint => "/derivations/image"

  draw :admin
end
