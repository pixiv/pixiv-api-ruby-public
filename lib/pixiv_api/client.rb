require 'forwardable'
require 'oauth2'

module PixivApi
  class Client
    class UnsupportedApiError < NotImplementedError; end

    extend Forwardable

    include Request::FavoriteUsers
    include Request::Util

    attr_reader :client, :access_token

    def_delegators :@access_token, :get, :post, :put, :patch, :delete

    def initialize(access_token:, refresh_token: nil, expires_at: nil)
      token_hash = {
        access_token: access_token,
        refresh_token: refresh_token,
        expires_at: expires_at.to_i
      }

      @client = OAuth2::Client.new(*client_configuration) do |builder|
        builder.request :multipart
        builder.request :url_encoded
        builder.adapter Faraday.default_adapter
      end

      @access_token = OAuth2::AccessToken.from_hash(client, token_hash)
    end

    def refresh!
      @access_token = @access_token.refresh!
    end

    private

    def unsupported!(path)
      raise PixivApi::Client::UnsupportedApiError, "route of #{path} is not supported."
    end

    def client_configuration
      configuration = PixivApi.configuration
      configuration.require_keys! # 必要な設定がなされているかチェック

      [
        configuration.client_id,
        configuration.client_secret,
        site: configuration.site,
        authorize_url: configuration.authorize_url,
        token_url: configuration.token_url
      ]
    end
  end
end
