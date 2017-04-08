class TransactionsController < ApplicationController
  def new
    @transaction = Transaction.new
    @card_number = session[:card]['pan'].gsub(/(.{4})/, '\1 ')
    @exp = session[:card]['expiration']

  end

  def create
    @marqeta = Adapter::MarqetaAdapter.new
    amount = params['transaction']['amount']
    card = session[:card]['token']

    trans_obj = JSON.parse(@marqeta.create_transaction(amount, card))
    session[:transaction] = trans_obj['transaction']

    ap '$' * 50
    ap 'NEW TRANSACTION'
    ap session[:transaction]
    ap '$' * 50

    redirect_to new_webhook_path
  end
end
