module PixivApi
  class Response
    class Pagination < Response
      def self.from_response(response, *attributes)
        new(response, *attributes)
      end

      def self.define_pagination_url(*attrs)
        attrs.each do |attr|
          define_method "#{attr}_url" do
            if self[attr]
              params = @request.params.merge('page' => self[attr])
              url = @request.url
              url.query = URI.encode_www_form(params)
              url
            end
          end
        end
      end

      attr_reader :previous, :next, :current, :per_page, :total, :pages
      define_pagination_url :previous, :next, :current
    end
  end
end
