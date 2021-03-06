﻿Design::Application.routes.draw do

  resources :after_graduations

  resources :guidances_users

  resources :guidances

  resources :events


  root :to => 'users#index'

  resources :certificates

  resources :sessions, only: [:new, :create, :destroy]
  match 'signup',  to: 'users#new',        via: 'get'
  match 'signin',  to: 'sessions#new',     via: 'get'
  match 'signout', to: 'sessions#destroy', via: 'delete'

  get 'statis' =>'statistics#index'
  post 'statis' => 'statistics#index'

  match 'users/new/:new_type' => 'users#new', :via => 'get', :as => 'create_new_user'
  match 'users/unauthorized/:list_type' => 'users#list_unauthorized', :via => 'get', :as => 'unauthorized_users'

  resources :users, :except => [:index, :new] do
    member do
      get 'authorize'
    end

    collection do
      get :list
      get :search
      get 'new_graduate'
      get 'nopermission'
    end
  end
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
