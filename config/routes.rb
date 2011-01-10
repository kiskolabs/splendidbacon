SplendidBacon::Application.routes.draw do

  match "/demo/new" => "demo#new", :as => "demo"
  devise_for :users
  devise_for :admins, :controllers => { :registrations => "magic/accounts" }, :path_names => { :sign_up => "new" }
  
  match "/magic" => "magic/pages#dashboard", :as => "admin_root_path"
  root :to => "pages#home"

  match "/sign_out_and_up" => "users#sign_out_and_up", :as => :sign_out_and_up
  
  resources :invitations
  
  resources :organizations do 
    get :timeline, :on => :member
    get :completed, :on => :member
    resources :memberships
  end
  
  resources :projects do
    resources :participants
    resources :statuses
  end
  
  resources :users, :only => [] do
    post :reset_authentication_token, :on => :collection
    resources :broadcasts, :only => [] do
      resources :broadcast_reads, :only => [ :create ]
    end
  end
  
  namespace :api do
    namespace :v1 do
      resources :projects, :only => [] do
        post :github, :on => :member
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

end
