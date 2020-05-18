Rails.application.routes.draw do
  resources :transformers, only: [:create, :destroy], param: :nickname
  match ":nickname" => "transformers#show", via: [:get]

  # :path => '/'
  # resources :someone, param: :category do
  #   resources :sometwo, param: :item
  # end
end
