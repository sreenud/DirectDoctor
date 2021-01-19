namespace :provider do
  resources :profiles

  resources :data do
    collection do
      get :degree
      get :holistic_medicine
      get :services
      get :languages
    end
  end
end
