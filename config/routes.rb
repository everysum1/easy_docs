Rails.application.routes.draw do
  get 'webhooks/new'

  resources :users, only: [:new, :create]
  resources :cards, only: [:new, :create]
  resources :transactions, only: [:new, :create]

  root "users#new"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
end
