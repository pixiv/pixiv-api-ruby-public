module PixivApi
  class Response
    class Request
      def initialize(response)
        @response = response
        @env = response.response.env
      end

      def full_url
        @env.url
      end

      def url
        URI(full_url.to_s.gsub(/\?.*$/, ''))
      end

      def query
        @env.url.query
      end

      def params
        Rack::Utils.parse_query(query)
      end
    end
  end
end
