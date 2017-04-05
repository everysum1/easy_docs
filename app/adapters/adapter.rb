module Adapter
  require 'rest-client'

  class Marqeta
    @base_url = ENV['BASE_URL']
    @headers = {
       :content_type => 'application/json',
      :accept => 'application/json',
      :Authorization => "#{ENV['APP_TOKEN']} #{ENV['MASTER_TOKEN']}"
    }

    def url 
      p '*' * 50
      p @base_url
      p '*' * 50
    end

    def new_user
      RestClient.post(@base_url, {}, @headers)
    end
  end

  class TwilioWrapper

  end
end
