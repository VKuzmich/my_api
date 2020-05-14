Rails.application.routes.draw do
  resources :transformers, only: [:show, :create, :destroy]
  # post :create, to: 'words#create'
end
