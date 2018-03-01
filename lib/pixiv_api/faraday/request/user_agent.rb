require_relative '../../version'

module PixivApi
  module Faraday
    module Request
      class UserAgent < ::Faraday::Middleware
        DEFAULT_USER_AGENT = "pixiv-api-ruby-public/#{PixivApi::VERSION}"

        def initialize(app, user_agent)
          @user_agent = user_agent
          super(app)
        end

        def call(env)
          env.request_headers['User-Agent'] = if env.request_headers['User-Agent']
                                                @user_agent + " (#{env.request_headers['User-Agent']})"
                                              else
                                                @user_agent
                                              end
          @app.call(env)
        end
      end
    end
  end
end
