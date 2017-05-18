require 'tmpdir'

module PixivApi
  class Configuration < Hash
    class MissingConfigurationError < StandardError; end
    class InvalidKeyError < StandardError; end

    REQUIRED_KEYS = %i(
      client_id client_secret site authorize_url token_url
    )

    OPTIONAL_KEYS = %i(
      cache_dir
    )

    (REQUIRED_KEYS + OPTIONAL_KEYS).each do |key|
      define_method key do
        self[key]
      end
    end

    def cache_dir
      self[:cache_dir] || Dir.mktmpdir('pixiv-api')
    end

    def []=(key, value)
      if allowed_keys.include?(key)
        super
      else
        raise InvalidKeyError, "#{key} is not configuration key."
      end
    end

    def require_keys!
      REQUIRED_KEYS.each do |key|
        raise MissingConfigurationError, "configuration requires '#{key}'" unless self[key]
      end

      self
    end

    private

    def allowed_keys
      REQUIRED_KEYS + OPTIONAL_KEYS
    end
  end
end
