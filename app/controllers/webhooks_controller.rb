class WebhooksController < ApplicationController
  def new
    @webhook = Webhook.new
    @amount = session[:transaction]['request_amount']
    @user = session[:user]['first_name']
    @merchant = session[:transaction]['card_acceptor']['name']
    @city = session[:transaction]['card_acceptor']['city']
    @state = session[:transaction]['card_acceptor']['state']
    @network = session[:transaction]['network']
    @status = session[:transaction]['state']
  end

  def create
    
    @twilio = Adapter::Twilio.new
    @twilio.send_message(params[:webhook])

    redirect_to webhooks_path
  end

  def index
  end
end
