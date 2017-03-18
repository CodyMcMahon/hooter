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

  delete 'user' => 'users#delete'
  
  delete 'ban'  => 'users#ban_user'
  
  post 'login' => 'session#create'

  post 'logout' => 'session#destroy'
  
  post 'change_password' => 'users#change_password'
  
  post 'change_avatar' => 'users#change_avatar'
  
  post 'like' => 'likes#create'
  
  post '/subhoot' => 'subhoots#create'

  get '/add_like_to/:to_id/:post_id' => 'likes#create'
  
  get '/add_hate_to/:to_id/:post_id' => 'hates#create'
  
  get '/search/:regex' => 'pages#search'
  
  get '/search' => 'pages#searchT'

  get '/edit_profile' => 'pages#edit_profile'

  get '/login' => 'pages#login'
  
  get '/signup' => 'pages#signup'
  
  get '/home' => 'pages#home'
  
  get '/help' => 'pages#help'
  
  get '/one_hoot' => 'pages#one_hoot'

  get '/explore' => 'pages#explore'
  
  get '/hoots' => 'pages#hoots'
  
  get '/following' => 'pages#following_self'
  
  get '/following/:id' => 'pages#following'
  
  get '/followers' => 'pages#followers_self'
  
  get '/followers/:id' => 'pages#followers'
  
  get '/kill_my_account' => 'pages#kill_my_account'
  
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
