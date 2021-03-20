namespace :provider do
  post 'profile/upload-image', to: "profiles#upload_image"
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
