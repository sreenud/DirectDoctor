namespace :admin do
  resources :dashboard, only: %i[index]
end
