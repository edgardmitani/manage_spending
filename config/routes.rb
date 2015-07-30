Rails.application.routes.draw do
  LOCALES = /en|pt\-BR/

  scope "(:locale)", locale: LOCALES do
    get 'home/index'

    resources :home_categories
    resources :herba_categories

    resources :home_clients
    resources :herba_clients

    resources :herba_incomes
    resources :herba_items do
      member do
        post "confirm_delivery"
      end
    end

    resources :herba_products do
      member do
        post "add_item"
      end
    end

    resources :herba_profiles

    resources :herba_titles

    resources :home_transactions do
      collection do
        get "new_credit_card"
        post "create_credit_card"
        get "new_transfer"
        post "create_transfer"
      end
    end

    resources :herba_transactions

    if Rails.env.production?
      devise_for :users, :controllers => { :registrations => "registrations" } 
    else
      devise_for :users
    end
  end

  get "/:locale" => "home#index", locale: LOCALES
  root to: "home#index"
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
