namespace :provider do
  resources :profiles
  resources :jobs

  resources :data do
    collection do
      get :degree
      get :holistic_medicine
      get :services
      get :languages
    end
  end
end
