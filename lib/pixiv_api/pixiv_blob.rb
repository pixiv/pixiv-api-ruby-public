require 'open-uri'
require 'securerandom'

module PixivApi
  class PixivBlob
    REFERER = 'https://www.pixiv.net/'

    attr_accessor :url

    def initialize(url)
      @url = url
    end

    def read
      open(&:read)
    end

    def open(&block)
      File.open(filepath, &block)
    end

    def to_path
      filepath
    end

    private

    def filepath
      File.join(PixivApi.configuration.cache_dir, filename).tap do |filepath|
        OpenURI.open_uri(url, 'Referer' => REFERER) do |uri|
          File.open(filepath, 'wb') { |f| f.write(uri.read) }
        end
      end
    end

    def filename
      extname = File.extname(@url).downcase
      "#{SecureRandom.uuid}#{extname}"
    end
  end
end
