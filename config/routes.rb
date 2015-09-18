Rails.application.routes.draw do
  resources :users
  resources :items

  get "register" => "users#new"
end
