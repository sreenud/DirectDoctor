namespace :provider do
  post 'profile/upload-image', to: "profiles#upload_image"
  resources :profiles do
    collection do
      get 'account_delete'
    end
  end

  resources :testimonials
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
