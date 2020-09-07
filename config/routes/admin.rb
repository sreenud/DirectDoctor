namespace :admin do
  resources :dashboard, only: %i[index]
  scope module: 'blog' do
    resources :topics
    resources :tips
    resources :tags
  end
  resources :users
end
