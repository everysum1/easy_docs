class UsersController < ApplicationController
  def new
    @user = User.new
    @marqeta = Adapter::MarqetaAdapter.new

    funding = JSON.parse(@marqeta.create_funding)

    # CREATE CARD PRODUCT
    data = JSON.parse(@marqeta.create_card_product(funding['token']))
    session[:card_product] = {
      name: data['name'],
      token: data['token']
    }
    
    ap '*' * 50
    ap 'CARD PRODUCT'
    ap session[:card_product]
    ap '*' * 50
    
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
    # @user = User.parse_user(data)
    redirect_to new_card_path
   
      # REDIRECT & PASS USER/CARDPRODUCT INFO TO NEXT VIEW

  
      # RELOAD PAGE
    

  end
end
