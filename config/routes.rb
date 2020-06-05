Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  # mount Rswag::Ui::Engine, at: '[api]-docs'
  # mount Rswag::Api::Engine, at: '[api]-docs'
  resources :transformers, only: [:create, :destroy], param: :nickname
  get ':nickname' => 'transformers#show'
end
