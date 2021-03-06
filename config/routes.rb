Rails.application.routes.draw do


  resources :categories 
  # question: why is params not showing category name when i use collection ?
  get 'categories/architecture', to: 'categories#show'
  get 'categories/graphic-design', to: 'categories#show'
  get 'categories/web-design', to: 'categories#show'
  get 'categories/audio-and-music', to: 'categories#show'
  get 'categories/film-and-video', to: 'categories#show'
  get 'categories/photography', to: 'categories#show'
  get 'categories/writing', to: 'categories#show'
  get 'categories/software-development', to: 'categories#show'
  get 'categories/other', to: 'categories#show'

  devise_for :users, controllers: {registrations: 'registrations'}

  # Shallow nesting of resources: 
  resources :projects do
    resources :designs, only: [:index, :new, :create]
  end

  resources :designs, only: [:show, :edit, :update, :destroy] do
    resources :reviews, only: [:new, :create]
  end
  
  resources :reviews, only: [:edit, :update, :destroy]
  
  root 'pages#home'

  get 'about', to: 'pages#about'
  get 'contact', to: 'pages#contact'
  get 'frequently_asked_questions', to: 'pages#FAQ'
  get 'how_it_works', to: 'pages#how_it_works'
  get 'events', to: 'pages#events'
  get 'community', to: 'pages#community'
  get 'blog', to: 'pages#blog'
  get 'tutorials', to: 'pages#tutorials'
  get 'press', to: 'pages#press'
  get 'creatives', to: 'pages#creatives'
  get 'customers', to: 'pages#customers'


  get 'myprojects' => "projects#customer"

  # get 'active-posts' => "designs#active_posts"

  get 'submitted-designs' => "designs#submitted_designs"


  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".


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
