Rails.application.routes.draw do
  root 'static_pages#index'

  resources :projects
  resources :users
  resources :items

  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'

  get "register" => "users#new"
end
