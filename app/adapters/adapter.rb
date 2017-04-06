module Adapter
  require 'rest-client'

  class MarqetaAdapter

    def initialize
      @base_url = "#{ENV['BASE_URL']}"
      @headers = {
        :content_type => :json,
        :accept => :json,
        :Authorization => "Basic #{ENV['APP_TOKEN']}:#{ENV['MASTER_TOKEN']}"
      }
    end

    def test_endpoint(endpoint)
      RestClient::Request.execute({
        method: :get,
        url: @base_url + endpoint,
        user: ENV['APP_TOKEN'],
        password: ENV['MASTER_TOKEN']
      })
    end 
    
    def create_card_product
      RestClient::Request.execute({
        method: :post,
        url: @base_url + "cardproducts",
        payload: {
          start_date: Date.today,
          name: Faker::Hipster.words(2).join(' ')
        }.to_json,
        user: ENV['APP_TOKEN'],
        password: ENV['MASTER_TOKEN'], 
        headers: {
          content_type: :json,
          accept: :json
        }
      })
    end

    def create_user
      RestClient::Request.execute({
        method: :post,
        url: @base_url + "users",
        payload: {
          first_name: Faker::GameOfThrones.character
        }.to_json,
        user: ENV['APP_TOKEN'],
        password: ENV['MASTER_TOKEN'],
        headers: {
          content_type: :json,
          accept: :json
        }
      })
    end

    def create_card(user_token, card_product_token)
      ap user_token
      ap card_product_token
      RestClient::Request.execute({
        method: :post,
        url: @base_url + "cards?show_cvv_number=true&show_pan=true",
        payload: {
          user_token: user_token,
          card_product_token: card_product_token
        }.to_json,
        user: ENV['APP_TOKEN'],
        password: ENV['MASTER_TOKEN'],
        headers: {
          content_type: :json,
          accept: :json
        }
      })
    end

    def create_transaction(card)
      RestClient::Request.execute({
        method: :post,
        url: @base_url + "simulate/authorization",
        payload: {
          card_token: card
        }.to_json,
        user: ENV['APP_TOKEN'],
        password: ENV['MASTER_TOKEN'],
        headers: {
          content_type: :json,
          accept: :json
        }
      })
    end

  end

  class TwilioAdapter

    def initialize
  
    end

    def test_endpoint(endpoint)
      ap "^" * 50
      ap @base_url + endpoint
      ap "^" * 50
      RestClient::Request.execute({
        method: :get,
        url: @base_url + endpoint,
        user: ENV['APP_TOKEN'],
        password: ENV['MASTER_TOKEN']
      })
    end

  end
end
