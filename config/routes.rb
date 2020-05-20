Rails.application.routes.draw do
  resources :transformers, only: [:create, :destroy], param: :nickname
  get ':nickname' => 'transformers#show'
end
