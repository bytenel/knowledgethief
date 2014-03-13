Kt::Application.routes.draw do

  resources :resumes


  resources :educations


  resources :experiences


  resources :skills


  resources :achievements

  resources :flags

  resources :activities

  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

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


  resources :rcomments
  match "/rcomments/forresource/:id" => "rcomments#forresource"

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
end
