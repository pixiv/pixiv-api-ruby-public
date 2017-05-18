require 'memoizable'
require 'active_support/core_ext/hash/indifferent_access'

module PixivApi
  class ArrayResponse < Array
    def self.from_response(response, klass, array)
      new(response).tap do |array_response|
        array.each do |attributes|
          array_response << klass.from_response(response, attributes)
        end
      end
    end

    def initialize(response)
      super()
      @response = response
    end

    def pagination
      @pagination ||= Response::Pagination.new(@response, @response.parsed['pagination'])
    end
  end
end
