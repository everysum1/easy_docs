class CardsController < ApplicationController
  def new
    @card = Card.new
  end

  def create
    # CREATE CARD W/ USER/CARDPRODUCT TOKENS
    @marqeta = Adapter::MarqetaAdapter.new
    data = JSON.parse(@marqeta.create_card(
      session[:user][:token], 
      session[:card_product][:token]
    ))
    session[:card] = data
    ap '#' * 50
    ap 'NEW CARD'
    ap session[:card]
    ap '#' * 50

    # REDIRECT & PASS CARD INFO TO TRANSACTION VIEW
    redirect_to new_transaction_path
  end
end
