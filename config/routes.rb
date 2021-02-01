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
  mount ProfilePicUploader.derivation_endpoint => "/derivations/image"

  draw :provider
  draw :admin

  get "*path", to: "application#raise_route_not_found", via: :all,
    constraints: lambda { |request| !request.fullpath.include?("/rails/active_storage/") }
  get '/:city_or_speciality(/:speciality_slug)', to: 'searches#specialized_search'
end
