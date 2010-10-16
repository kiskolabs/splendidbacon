SplendidBacon::Application.routes.draw do

  devise_for :users

  root :to => "pages#home"
  
  resources :organizations do 
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
