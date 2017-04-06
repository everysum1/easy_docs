class UsersController < ApplicationController
  def new
    @user = User.new
    @marqeta = Adapter::MarqetaAdapter.new
    # CREATE CARD PRODUCT
    data = JSON.parse(@marqeta.create_card_product)
    session[:card_product] = {
      name: data['name'],
      token: data['token']
    }
    
  end

  def create
    # CREATE USER & SAVE IN DB
    @marqeta = Adapter::MarqetaAdapter.new
    user = JSON.parse(@marqeta.create_user)
    session[:user] = {
      first_name: user['first_name'],
      token: user['token']
    }
    # @user = User.parse_user(data)
    redirect_to new_card_path(
      user: session[:user], 
      card_product: session[:card_product]
    )
   
      # REDIRECT & PASS USER/CARDPRODUCT INFO TO NEXT VIEW

  
      # RELOAD PAGE
    

  end
end
