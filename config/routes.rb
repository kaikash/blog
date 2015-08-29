Rails.application.routes.draw do

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'web/articles#index'

  namespace :web do
    resources :articles, except: [:edit, :update]
    # resource :search, only: [:create, :new],
      # controller: :search

    post '/search', to: "search#search", as: "search"
    # get '/search-home', to: "search#result", as: "search_result"

    get '/hashtag/:hashtag', to: "hashtags#show", as: "hashtag"
    post '/hashtag/:hashtag', to: "hashtag#create", as: "hashtags"

    get '/profile', to: "users#index", as: "profile"
    get '/profiles/:id', to: "users#show", as: "profiles"
    

    get "/logout", to: "session#destroy", as: "logout"
    get "/auth/:provider/callback", to: "session#create", as: "auth_callback"
    get "/auth/failure", to: "session#failure", as: "auth_failure"
  end

  namespace :api do
    resources :comments, only: [:create, :destroy]
  end

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
