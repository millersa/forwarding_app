ForwardingApp::Application.routes.draw do



  resources :statistics
  resources :drivers

  resources :companies


  root :to => 'tenders#index'
  resources :tenders
  resources :users


   post 'tenders/updateobjem_select/:vesJs', :controller=>'tenders', :action => 'update_objem_select'
   post 'tenders/updatemarka_select/:objemJs&:vesJs', :controller=>'tenders', :action => 'update_marka_select'
   post 'tenders/updatetipkuzova_radio/:objemJs&:vesJs&:markaJs', :controller=>'tenders', :action => 'update_tipkuzova_radio'
   post 'tenders/updaterastentovka_checkbox/:objemJs&:vesJs&:markaJs&:tipkuzovaJs', :controller=>'tenders', :action => 'update_rastentovka_checkbox'
   post 'tenders/updatedriverdata/:objemJs&:vesJs&:markaJs&:tipkuzovaJs&:rastentovkaJs', :controller=>'tenders', :action => 'update_driver_data'
   post 'statistics/updatestats/:period&:user_id', :controller=>'statistics', :action => 'update_stats_period'
   post 'drivers/update_data/:id', :controller=>'drivers', :action => 'updateShow'
   post 'users/update_data/:id', :controller=>'users', :action => 'updateShow'
   post 'companies/update_data/:id', :controller=>'companies', :action => 'updateShow'
   post 'tenders/update_data/:id', :controller=>'tenders', :action => 'updateShow'
   post 'tenders/update_dataT/:id', :controller=>'tenders', :action => 'updateShowT'
   

  resources :sessions, :only => [:new, :create, :destroy]

  match '/adduser',  to: 'users#new'
  match '/stats',  to: 'statistics#stats'
  match '/signin',  to: 'sessions#new'
  match '/signout', to: 'sessions#destroy', via: :delete
  match '/newtender',  to: 'tenders#new'
  match '/donetender',  to: 'tenders#done'

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
