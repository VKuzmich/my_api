Rails.application.routes.draw do
  resources :transformers, only: [:show, :create, :destroy]
  # # post :create, to: 'words#create'
  # get :nickname, to: 'transformers#show'
  # post '', to: 'transformers#create'
  # destroy :nickname, to: 'transformers#destroy'
end
