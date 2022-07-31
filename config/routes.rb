Rails.application.routes.draw do
  resources :sessions, omly: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :show]
end
