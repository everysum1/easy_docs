class WebhooksController < ApplicationController
  def new
    @webhook = Webhook.new
    @amount = session[:transaction]['request_amount']
    @user = session[:user][:first_name]
    @merchant = session[:transaction]['card_acceptor']['name']
    @city = session[:transaction]['card_acceptor']['city']
    @state = session[:transaction]['card_acceptor']['state']
    @network = session[:transaction]['network']
    @status = session[:transaction]['state']
  end

  def create
    @twilio = Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']
    # @twilio.send_message(params[:webhook])
    alert_message = "Your Marqeta account has just received an authorization request for #{params['webhook'][:amount]} from #{params['webhook'][:user]} at #{params['webhook'][:merchant]} located in #{params['webhook'][:city]},#{params['webhook'][:state]}, processed over the #{params['webhook'][:network]} network. It is currently in #{params['webhook'][:status]} state."

    @twilio.messages.create(
      from: ENV['TWILIO_NUMBER'],
      to:   params['webhook'][:phone],
      body: alert_message,
    )

    redirect_to webhooks_path
  end

  def index
  end
end
