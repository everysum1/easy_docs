class UsersController < ApplicationController

  def new
    @user = User.new
    @marqeta = Adapter::MarqetaAdapter.new
    
    funding = JSON.parse(@marqeta.create_funding)
    session[:funding] = funding

    ap '*' * 50
    ap 'NEW FUNDING SOURCE'
    ap session[:funding]
    ap '*' * 50

    card_product = JSON.parse(@marqeta.create_card_product(funding['token']))
    session[:card_product] = {
      name: card_product['name'],
      token: card_product['token']
    }

    ap '!' * 50
    ap 'NEW CARD PRODUCT'
    ap session[:card_product]
    ap '!' * 50

  end

  def create
    # CREATE USER & SAVE IN DB
    @marqeta = Adapter::MarqetaAdapter.new
    user = JSON.parse(@marqeta.create_user)
    session[:user] = {
      first_name: user['first_name'],
      token: user['token']
    }
    
    ap '^' * 50
    ap 'NEW USER'
    ap session[:user]
    ap '^' * 50

    redirect_to new_card_path
  end

end
