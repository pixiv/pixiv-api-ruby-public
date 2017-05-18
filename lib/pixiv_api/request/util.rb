require 'active_support'
require 'active_support/core_ext/hash/slice'

module PixivApi
  module Request
    module Util
      def object_from_response(klass, http_method, path, *opts)
        response = request(http_method, path, *opts)
        parsed = response.parsed['response']
        parsed = parsed[0] if parsed.is_a?(Array)
        return if parsed.nil?

        klass.from_response(response, parsed)
      end

      def objects_from_response(klass, http_method, path, *opts)
        response = request(http_method, path, *opts)
        objects_from_array(response, klass, response.parsed['response'] || [])
      end

      def action_from_response(http_method, path, *opts)
        response = request(http_method, path, *opts)
        Response::Action.from_response(response)
      end

      private

      def objects_from_array(response, klass, array)
        ArrayResponse.from_response(response, klass, array)
      end

      def request(http_method, path, *opts)
        options = opts.extract_options!

        public_send(http_method, path, options.slice(:params, :body))
      end
    end
  end
end
