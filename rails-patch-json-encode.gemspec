# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rails/patch/json/encode/version'

Gem::Specification.new do |spec|
  spec.name          = "rails-patch-json-encode"
  spec.version       = Rails::Patch::Json::Encode::VERSION
  spec.authors       = ["lulalala", "Jason Hutchens"]
  spec.email         = ["mark@goodlife.tw"]
  spec.description   = %q{A monkey patch to speed up Rails' JSON generation time.}
  spec.summary       = %q{A monkey patch to speed up Rails' JSON generation time.}
  spec.homepage      = "https://github.com/GoodLife/rails-patch-json-encode"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16.0"
  spec.add_development_dependency "rake", "~> 12.3.0"
  spec.add_development_dependency "activesupport", "~> 5.1.4"
  spec.add_development_dependency "oj"
  spec.add_development_dependency "byebug"

  spec.add_dependency 'multi_json', '>= 1.9.3', '~> 1.0'
end
