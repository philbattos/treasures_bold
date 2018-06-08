Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get 'home',   to: 'support#home',            as: :home
  get 'search', to: 'support#advanced_search', as: :advanced_search

  resources :geo_features, only: [:index, :show]

end
