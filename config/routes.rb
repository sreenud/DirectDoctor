Rails.application.routes.draw do
  devise_for :users
  root 'home#index'
  get 'search', to: "searches#index"
  get 'search-map', to: "searches#index_two"
  get 'job-search', to: "jobs#search"
  get 'doctor/profile/:fdd_id', to: "doctors#show"
  get "/*any", to: "redirects#index", constraints: RedirectConstraint.new

  resources :blogs, only: [:index, :show]
  resources :tips, only: [:index]
  get 'about-us', to: "abouts#index"
  resources :doctors do
    resources :reviews, only: [:index, :create]
  end
  get "/blogs/:tip_slug/:id", to: "tips#show"

  resources :surveys, only: [:index, :create]
  resources :jobs, only: [:index, :show] do
    collection do
      get :search
    end
  end

  mount Shrine.upload_endpoint(:cache) => "/images/upload"
  mount ProfilePicUploader.derivation_endpoint => "/derivations/image"

  draw :admin
end
