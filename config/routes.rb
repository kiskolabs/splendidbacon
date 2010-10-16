SplendidBacon::Application.routes.draw do

  devise_for :users

  root :to => "pages#home"
  
  resources :invitations
  
  resources :organizations do 
    resources :memberships
  end
  
  resources :projects do
    resources :participants
  end

end
