SplendidBacon::Application.routes.draw do
  
  match "/demo/new" => "demo#new", :as => "demo"
  devise_for :users

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

end
