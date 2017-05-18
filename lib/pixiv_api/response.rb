require 'memoizable'
require 'active_support/core_ext/hash/indifferent_access'

module PixivApi
  class Response
    autoload :User, 'pixiv_api/response/user'
    autoload :Identity, 'pixiv_api/response/identity'
    autoload :FavoriteUser, 'pixiv_api/response/favorite_user'
    autoload :Pagination, 'pixiv_api/response/pagination'
    autoload :Request, 'pixiv_api/response/request'

    include Memoizable
    extend Forwardable

    attr_reader :attributes, :response
    alias_method :to_h, :attributes

    def_delegators :@attributes, :fetch, :slice, :values_at

    class << self
      def from_response(response, *attributes)
        new(response, *attributes)
      end

      def attr_reader(*attributes)
        attributes.each do |attr|
          define_attribute_method(attr)
          define_predicate_method(attr)
        end
      end

      def define_attribute_method(key1, klass = nil, key2 = nil)
        define_method(key1) do
          if klass.nil?
            @attributes[key1]
          else
            if @attributes[key1]
              dup = attributes_for_object(key1, key2)
              klass.new(@response, dup)
            else
              nil
            end
          end
        end

        memoize(key1)
      end

      def define_attributes_method(key1, klass = nil, key2 = nil)
        define_method(key1) do
          if klass.nil?
            @attributes[key1]
          else
            @attributes[key1].map do |attr|
              dup = attributes_for_object(key1, key2)
              klass.new(@response, dup)
            end
          end
        end

        memoize(key1)
      end

      def define_time_method(*attributes)
        attributes.each do |attr|
          define_method(attr) do
            Time.parse(@attributes[attr])
          end

          memoize(attr)
        end
      end

      def define_blob_method(key)
        method_name = :"blob_#{key}"

        define_method method_name do
          fetch(key, {}).each_with_object({}) do |(key, value), memo|
            memo[key] = PixivApi::PixivBlob.new(value)
          end
        end

        memoize(method_name)
      end

      private

      def define_predicate_method(key1, key2 = key1)
        predicate_method = :"#{key1}?"

        define_method(predicate_method) do ||
          !!@attributes[key2]
        end

        memoize(predicate_method)
      end
    end

    def initialize(response, attributes = {})
      @response = response
      @request = PixivApi::Response::Request.new(response)
      @attributes = attributes.with_indifferent_access
    end

    def [](method)
      public_send(method.to_sym)
    rescue NoMethodError
      nil
    end

    private

    def attributes_for_object(key1, key2=nil)
      if key2.nil?
        @attributes[key1]
      else
        attributes = @attributes.dup
        attributes.delete(key1).merge(key2 => attributes)
      end
    end
  end
end
