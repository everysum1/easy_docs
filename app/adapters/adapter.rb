module Adapter
  require 'rest-client'

  class Marqeta
    @base_url = ENV['BASEURL']

    def url 
      p '*' * 50
      p @base_url
      p '*' * 50
    end
  end

  class TwilioWrapper

  end
end
