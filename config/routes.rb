Kt::Application.routes.draw do

  resources :resumes


  resources :educations


  resources :experiences


  resources :skills


  resources :achievements

  get "d3/index"

  resources :flags

  resources :activities
  
  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  #resources :authentications

  resources :paths

  match '/in_paths/:path_id/resource/:resource_id/add', :to => 'in_paths#add_resource_to_path',
        :as => 'add_resource_to_path', :via => 'post'
  match '/in_paths/:path_id/resource/:resource_id/pos/:position/remove', :to => 'in_paths#remove_resource_from_path',
        :as => 'remove_resource_from_path', :via => 'post'

  mount Engage::Engine => '/engage', :as => 'engage'

  resources :resources do
      member { post :vote }
      collection {get :search}
    end

  devise_for :users


  resources :rcomments do
     member {post :forresource}
  end

  resources :userResourceView

  get "home/index"

  devise_scope :user do
    get "/login" => "devise/sessions#new"

  end

  devise_for :user, :path => '', :path_names => {:sign_up => "register" }

  match '/user_profile', :to =>'users#index'
  match '/user_resume', :to => 'users#resume'
  match '/ajaxProfile', :to =>'users#ajaxProfile'
  match '/ajaxPaths', :to =>'paths#ajaxPaths'

  get 'tags/:tag', to: 'resources#index', as: :tag

  match '/infiniteScroll' => 'home#infiteScroll'
  match '/auth/:provider/callback' => 'authentications#create'
  match '/auth/:provider/failure', :to => 'authentications#failure'
  #match '/auth/:provider/callback?error_reason...', :to => 'profiles#failure'

  match '/resources', to: 'resources#create', :via => :post
  match 'contact' => 'contact#new', :as => 'contact', :via => :get
  match 'contact' => 'contact#create', :as => 'contact', :via => :post
  match '/forums' => 'forums#index'

  root to: 'home#index', :as => :home


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
  #     resources :rcomments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :rcomments
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
