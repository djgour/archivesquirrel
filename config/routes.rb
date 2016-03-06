Rails.application.routes.draw do

  root 'static_pages#index'

  resources :projects do
     resources :items
  end
  
  resources :users
 
  

  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  # Uses 'internal' in invite routes to distinguish from 'external' invites to
  # people who do not have an account with the app yet.
  post   'internal_invite' => 'invitations#create'
  delete 'cancel_invite' => 'invitations#cancel'
  post   'accept_internal_invite' => 'participates#create'
  delete 'decline_invite' => 'invitations#decline'

  get "register" => "users#new"
end
