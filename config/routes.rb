Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root 'home#index'
  get 'search', to: "searches#index"
  get 'search-map', to: "searches#index_two"
  get 'job-search', to: "jobs#search"
  get ':state/doctor/:fdd_id/:doctor_name', to: "doctors#show"
  get "/*any", to: "redirects#index", constraints: RedirectConstraint.new

  resources :blogs, only: [:index, :show]
  resources :tips, only: [:index]
  get 'about-us', to: "abouts#index"
  get 'onboarding/step1', to: "onboarding#step1"
  post 'onboarding/step1', to: "onboarding#create_step1"
  get 'onboarding/thankyou', to: "onboarding#thankyou"
  get 'list-your-practice', to: "list_your_practice#index"
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

  resources :data do
    collection do
      get :doctor_names
    end
  end

  mount Shrine.upload_endpoint(:cache) => "/images/upload"
  mount ImageUploader.derivation_endpoint => "/derivations/image"

  namespace :users do
    resource :profile, only: [:edit] do
      collection do
        patch 'update_password'
      end
    end
  end

  draw :provider
  draw :admin

  # place is nothing but state here
  get '/:place(/:style)(/:speciality_slug)(/:location)', to: 'searches#specialized_search'

  get "*path", to: "application#raise_route_not_found", via: :all,
    constraints: lambda { |request| !request.fullpath.include?("/rails/active_storage/") }
end
