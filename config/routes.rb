SplendidBacon::Application.routes.draw do

  match "/demo/new" => "demo#new", :as => "demo"
  devise_for :users
  devise_for :admins, :controllers => { :registrations => "magic/accounts" }, :path_names => { :sign_up => "new" }
  
  match "/magic" => "magic/pages#dashboard", :as => "admin_root_path"
  root :to => "pages#home"
  
  resources :invitations
  
  resources :organizations do 
    get :timeline, :on => :member
    resources :memberships
  end
  
  resources :projects do
    resources :participants
    resources :statuses
  end
  
  namespace :api do
    namespace :v1 do
      resources :projects, :only => [] do
        post :github, :on => :member
      end
    end
  end
  
  namespace :magic do
    root :to => "pages#dashboard"
    match "update_stats" => "pages#update_stats"
    resources :broadcasts
  end

end
