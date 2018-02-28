require 'faraday'

module PixivApi
  module Faraday
    module Request
      autoload :UserAgent, 'pixiv_api/faraday/request/user_agent'

      ::Faraday::Request.register_middleware user_agent: -> { UserAgent }
    end
  end
end
