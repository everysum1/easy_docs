class TransactionsController < ApplicationController
  def new
    @transaction = Transaction.new
  end

  def create
    @marqeta = Adapter::MarqetaAdapter.new
    amount = params['transaction']['amount']
    card = session[:card]['token']

    transaction = JSON.parse(@marqeta.create_transaction(amount, card))
    session[:transaction] = transaction

    ap '$' * 50
    ap 'NEW CARD'
    ap session[:transaction]
    ap '$' * 50

    redirect_to new_webhook_path
  end
end
