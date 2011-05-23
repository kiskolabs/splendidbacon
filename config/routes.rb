SplendidBacon::Application.routes.draw do

  match "/demo/new" => "demo#new", :as => "demo"
  devise_for :users
  devise_for :admins, :controllers => { :registrations => "magic/accounts" }, :path_names => { :sign_up => "new" }
  
  match "/magic" => "magic/pages#dashboard", :as => "admin_root_path"
  root :to => "pages#home"
  match "/privacy" => "pages#privacy"
  match "/terms" => "pages#terms"
  match "/sign_out_and_up" => "users#sign_out_and_up", :as => :sign_out_and_up
  
  match "/zendesk/authorize" => "zendesk_auth#authorize"
  match "/zendesk/logout" => "zendesk_auth#logout"
  
  resources :invitations
  
  resources :organizations do 
    get :timeline, :on => :member
    get :completed, :on => :member
    resources :memberships
  end
  
  match "projects/:id/guest/:token" => "projects#guest", :as => :guest_project
    
  resources :projects do
    member do
      put :enable_guest_access, :disable_guest_access
    end
    resources :participants
    resources :statuses do
      match "pages((/:restore)/:page)" => "statuses#index", :as => :page, :constraints => { :page => /\d+/ }, :on => :collection
    end
    resources :notifications, :only => [ :create, :destroy ]
  end
  
  resources :users, :only => [] do
    get :reset_authentication_token, :on => :collection
    resources :broadcasts, :only => [] do
      resources :broadcast_reads, :only => [ :create ]
    end
  end
  
  namespace :api do
    namespace :v1 do
      resources :projects, :only => [] do
        post :github, :on => :member
        post :pivotal_tracker, :on => :member
      end
      resources :users, :only => [] do
        post :mailchimp, :on => :collection
        get :mailchimp, :on => :collection
      end
      
      authenticate :user do
        resources :organizations, :only => [:index, :show] do
          resources :projects, :only => [:index, :show] do
            resources :statuses, :only => [:index]
          end
          resources :users, :only => [:index]
        end
      end
    end
  end
  
  namespace :magic do
    root :to => "pages#dashboard"
    match "update_stats" => "pages#update_stats"
    resources :broadcasts
    resources :users
  end
  
  authenticate :admin do
    mount Resque::Server.new, :at => "/magic/resque"
  end

end
