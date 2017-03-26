Rails.application.routes.draw do

  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :relationships
  resources :posts
  resources :likes
  resources :hates
  root 'pages#index'
  
  #remove user(and all content)
  delete 'user' => 'users#delete'
  
  delete 'ban'  => 'users#ban_user'
  
  #post requests
  post 'login' => 'session#create'

  post 'logout' => 'session#destroy'
  
  post 'change_password' => 'users#change_password'
  
  post 'change_avatar' => 'users#change_avatar'
  
  post 'like' => 'likes#create'
  
  post 'hate' => 'hates#create'
  
  post '/subhoot' => 'subhoots#create'
  
  post '/hoot' => 'posts#hoot'
  
  #jsons
  get '/my_timeline' => 'posts#timeline'
  
  get '/my_timeline_update/:id' => 'posts#timeline_update'
  
  get '/all_hoots' => 'posts#explore'
  
  get '/all_hoots_update/:id' => 'posts#explore_update'
  
  get '/hoots_for/:id' => 'posts#hoots_for'
  
  get '/memes' => 'posts#memes'
  
  get '/fellow_hooters' => 'users#fellow_hooters'
  
  get '/hoot_hoots' => 'posts#hoot_hoots'
  
  get '/hoot_hoots_update/:id' => 'posts#hoot_hoots_update'
  
  get '/followings_for/:id' => 'relationships#followings_for'
  
  get '/followers_for/:id' => 'relationships#followers_for'
  
  get '/hoots_through_regex/:search' => 'posts#hoots_through_regex'
  
  get '/hooters_through_regex/:search' => 'users#hooters_through_regex'
  
  get '/single_json/:id' => 'posts#single_json'
  
  get '/get_subhoots/:id' => 'subhoots#get_subhoots'
  
  get '/get_subhoots_update/:id/:from_id' => 'subhoots#get_subhoots_update'
  
  #pages
  get '/search' => 'pages#search'

  get '/edit_profile' => 'pages#edit_profile'

  get '/login' => 'pages#login'
  
  get '/signup' => 'pages#signup'
  
  get '/home' => 'pages#home'
  
  get '/help' => 'pages#help'
  
  get '/one_hoot' => 'pages#one_hoot'

  get '/explore' => 'pages#explore'
  
  get '/hoots' => 'pages#hoots'
  
  get '/following/:id' => 'pages#following'
  
  get '/followers/:id' => 'pages#followers'
  
  get '/single_hoot' => 'pages#no_hoot'
  
  get '/single_hoot/:id' => 'pages#single_hoot'
  
  get '/:id' => 'pages#profile'

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
