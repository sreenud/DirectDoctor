namespace :admin do
  post "doctors/upload-image", to: "doctors#upload_image"
  resources :dashboard, only: %i[index]
  scope module: "blog" do
    resources :topics
    resources :tips
    resources :tags
  end
  resources :users
  resources :media_storages, only: %i[create destroy]
  resources :page_redirects
  resources :doctors
  resources :jobs
  resources :specialities
  resources :doctor_degrees
  resources :services
  resources :reviews
  resources :languages
  resources :claim_profiles
  resources :states do
    resources :locations
  end

  resources :data do
    collection do
      get :degree
      get :holistic_medicine
      get :services
      get :languages
      get :doctor_names
    end
  end
end
