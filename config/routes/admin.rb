namespace :admin do
  resources :dashboard, only: %i[index]
  scope module: 'blog' do
    resources :topics
    resources :tips
    resources :tags
  end
  resources :users
  resources :media_storages, only: %i[create destroy]
  resources :page_redirects
  resources :doctors
  resources :specialities
  resources :doctor_degrees
  resources :services
  resources :languages
  resources :data do
    collection do
      get :degree
      get :holistic_medicine
      get :services
      get :languages
    end
  end
end
