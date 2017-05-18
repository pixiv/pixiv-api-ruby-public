# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pixiv_api/version'

Gem::Specification.new do |spec|
  spec.name          = 'pixiv_api'
  spec.version       = PixivApi::VERSION
  spec.authors       = ['alpaca-tc']
  spec.email         = ['alpaca-tc@alpaca.tc']

  spec.summary       = %q{pixiv public api client}
  spec.description   = %q{pixiv public api client.}
  spec.homepage      = 'https://github.com/pixiv/pixiv-api-ruby-public'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.test_files    = Dir['spec/**/*_spec.rb']
  spec.require_paths = ['lib']

  spec.add_dependency 'oauth2', '>= 1.0'
  spec.add_dependency 'memoizable', '>= 0.4'
  spec.add_dependency 'activesupport', '>= 4.0'
  spec.add_development_dependency 'bundler', '>= 1.10'
  spec.add_development_dependency 'rake', '>= 10.0'
  spec.add_development_dependency 'rspec', '>= 3.3'
  spec.add_development_dependency 'vcr', '>= 2.9'
  spec.add_development_dependency 'webmock', '>= 3.0'
  spec.add_development_dependency 'pry', '>= 0.10'
end
