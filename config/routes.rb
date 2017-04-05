Rails.application.routes.draw do
  get 'transactions/new'

  get 'transactions/create'

  get 'cards/new'

  get 'cards/create'

  get 'card_products/new'

  get 'card_products/create'

  root 'users#new'

  get 'wizard_pages/createUser'

  get 'wizard_pages/createCard'

  get 'wizard_pages/transaction'

  get 'wizard_pages/webhook'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
end
