Rails.application.routes.draw do


  devise_for :users, controllers: {omniauth_callbacks: 'omniauth_callbacks', registrations: 'registrations'}

  get 'welcome/index'
  root 'welcome#index'

    
  resources :passwords do
    collection do
      put 'update_password', as: :update
      get 'change_password', as: :change
    end
  end


  resources :polls do
    collection do
      put 'deactivate/:id' => 'polls#deactivate', as: :delete
      put 'activate/:id' => 'polls#activate', as: :activate
    end
  end

  resources :comments do
    collection do
      put 'remove/:id' => 'comments#remove', as: :delete
    end
  end

  resources :categories do
    collection do
      put 'deactivate/:id' => 'categories#deactivate', as: :delete
      put 'activate/:id' => 'categories#activate', as: :activate
    end
  end

  resources :users do
    collection do
      put 'deactivate/:id' => 'users#deactivate', as: :delete
      put 'activate/:id' => 'users#activate', as: :activate
    end
  end

  resources :votes

  get 'search/users' => 'search#users'
  get 'search/polls' => 'search#polls'


  
  
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
