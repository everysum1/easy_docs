module Adapter
  require 'rest-client'

  class MarqetaAdapter

    def initialize
      @base_url = "#{ENV['BASE_URL']}"
    end

    def test_endpoint(endpoint)
      RestClient::Request.execute({
        method: :get,
        url: @base_url + endpoint,
        user: ENV['APP_TOKEN'],
        password: ENV['MASTER_TOKEN']
      })
    end 

    def create_funding
      RestClient::Request.execute({
        method: :post,
        url: @base_url + "fundingsources/program",
        payload: {
          name: 'Unlimited Funds',
          active: true
        }.to_json,
        user: ENV['APP_TOKEN'],
        password: ENV['MASTER_TOKEN'], 
        headers: {
          content_type: :json,
          accept: :json
        }
      })
    end
    
    def create_card_product(funding_token)
      RestClient::Request.execute({
        method: :post,
        url: @base_url + "cardproducts",
        payload: {
          start_date: Date.today,
          name: Faker::Hipster.words(2).join(' '),
          active: true,
          config: {
            fulfillment: {
              payment_instrument:"VIRTUAL_PAN"
            },
            poi: {
              other: {
                allow: true
              },
              ecommerce: true
            },
            transaction_controls: {
              allow_gpa_auth: true,
              disable_avs: true
            },
            card_life_cycle: {
              activate_upon_issue: true
            },
            jit_funding: {
              program_funding_source: {
                funding_source_token: funding_token,
                refunds_destination: 'PROGRAM_FUNDING_SOURCE',
                enabled: true
              }
            }
          }
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

    def create_transaction(amount, card)
      RestClient::Request.execute({
        method: :post,
        url: @base_url + "simulate/authorization",
        payload: {
          amount: amount,
          card_token: card, 
          mid: '1234567890'
        }.to_json,
        user: ENV['APP_TOKEN'],
        password: ENV['MASTER_TOKEN'],
        headers: {
          content_type: :json,
          accept: :json
        }
      })
    end

    def add_webhook(phone, card, amount)
      RestClient::Request.execute({
        method: :post,
        url: @base_url + "simulate/authorization",
        payload: {
          card_token: card, 
          amount: amount,
          mid: '1234567890', 
          webhook: {
            endpoint: "", #ADD TWILIO endpoint
            username: "",
            password: ""
          }
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

  class Twilio

    def initialize
    end

    def send_message(webhook)
      twilio_number = ENV['TWILIO_NUMBER']
      client = Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']

      alert_message = "Your Marqeta account has just received an authorization request for #{webhook[:amount]} from #{webhook[:user]} at #{webhook[:merchant]} located in #{webhook[:city]},#{webhook[:state]}, processed over the #{webhook[:network]} network. It is currently in #{webhook[:status]} state."

      client.messages.create(
        from: twilio_number,
        to:   params[:phone],
        body: alert_message,
      )
    end
  end

end
