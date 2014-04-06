CacheMapActiveRecord::Application.routes.draw do
  # devise_for :users
  
  root 'queries#home'

  # landings custom routes
  # get 'search_results',  to: 'landings#search',  as: :search_results
  get 'search_results',  to: 'landings#search',  as: :search_landings
  get 'places/:id',      to: 'landings#show',   as: :place
  # get 'places',          to: 'landings#search', as: :landing_search

  # minings custom routes
  get 'search',          to: 'queries#new',  as: :search
  get 'minings',         to: 'queries#index'
  # get 'minings/data', to: 'queries#index'
  # get 'advanced_search', to: 'queries#index'

  ##############################################
  #####      routes for static pages       #####
  ##############################################
  get 'about',    to: 'static_pages#about', as: :about
  get 'chase',    to: 'static_pages#chase', as: :chase
  get 'poem',     to: 'static_pages#poem',  as: :poem
  
  get 'contact',  to: 'remarks#new',        as: :contact

  # devise_scope :user do
    # get "sign_in", to: "devise/sessions#new", as: :sign_in
  # end

  # resources :users
  resources :queries, only: [:create]
  # resources :landings, only: :show
  resources :remarks, only: [:new, :create]


  ### Current routes
  ### non-members
  # /search         (minings#new page)
  # /search_results (map)
  # /places/:id     (landings#show page)
  
  ### members
  # none

  ### super-members (admins)
  # none


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end
  
  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
