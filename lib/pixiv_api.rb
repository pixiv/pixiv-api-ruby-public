require 'active_support/core_ext/array/extract_options'
require 'active_support/core_ext/hash/deep_merge'

module PixivApi
  autoload :VERSION, 'pixiv_api/version'
  autoload :Client, 'pixiv_api/client'
  autoload :ArrayResponse, 'pixiv_api/array_response'
  autoload :Configuration, 'pixiv_api/configuration'
  autoload :Identity, 'pixiv_api/identity'
  autoload :Request, 'pixiv_api/request'
  autoload :Response, 'pixiv_api/response'
  autoload :PixivBlob, 'pixiv_api/pixiv_blob'

  def self.configure
    yield(configuration)
  end

  def self.configuration
    @configuration ||= Configuration.new
  end
end
