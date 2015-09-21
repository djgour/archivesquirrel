Rails.application.routes.draw do
  resources :projects

  resources :users
  resources :items

  get "register" => "users#new"
end
