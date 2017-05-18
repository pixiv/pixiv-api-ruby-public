module PixivApi
  class Response
    class Identity < Response
      attr_reader :id

      def initialize(*)
        super
        @attributes.fetch(:id)
      end
    end
  end
end
