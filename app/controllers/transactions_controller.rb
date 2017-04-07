class TransactionsController < ApplicationController
  def new
    @transaction = Transaction.new
    @user = session[:user]
    funding = session[:funding]
    @marqeta = Adapter::MarqetaAdapter.new
    data = JSON.parse(@marqeta.fund_user(@user[:token], funding['token']))
    ap session[:funding][:amount] = data['amount']
    ap '@' * 50
    ap 'NEW USER FUNDED'
    ap data
    ap '@' * 50
  end

  def create
    # CREATE TRANSACTION W/ CARD TOKEN
    @marqeta = Adapter::MarqetaAdapter.new
    card = session[:card]['token']
    data = JSON.parse(@marqeta.create_transaction(card, params['transaction']['amount']))
    session[:transaction] = data['transaction']
    ap '!' * 50
    ap data
    ap '!' * 50
    # REDIRECT TO WEBHOOK PAGE & PASS CARD TOKEN
    redirect_to new_webhook_path
  end
end
