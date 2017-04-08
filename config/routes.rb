Rails.application.routes.draw do

  root "users#new"
  resources :users, only: [:new, :create]
  resources :cards, only: [:new, :create]
  resources :transactions, only: [:new, :create]
  resources :webhooks, only: [:new, :create, :index]

  post 'twilio/voice' => 'twilio#voice'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
end
