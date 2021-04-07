namespace :patient do
  resources :profiles do
    collection do
      get "account_delete"
    end
  end
  resources :favourites
  resources :reviews
end
