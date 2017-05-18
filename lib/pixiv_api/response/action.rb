module PixivApi
  class Response
    class Action < Response
      attr_reader :status

      def self.from_response(response)
        new(response, response.parsed)
      end

      def errors
        fetch('errors', {})
      end

      def success?
        status == 'success'
      end

      def failure?
        !success?
      end
    end
  end
end
