Rails.application.routes.draw do
  get 'wizard_pages/createUser'

  get 'wizard_pages/createCard'

  get 'wizard_pages/transaction'

  get 'wizard_pages/webhook'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'application#test'
end
