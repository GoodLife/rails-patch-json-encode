require 'benchmark'
require 'json'
require 'yajl'
require 'active_support'
require 'active_support/json'
require 'active_support/core_ext/object/json'
require 'rails/patch/json/encode'

puts <<MESSAGE
Benchmark: base classes patch mode

Gem versions:
  ActiveSupport: #{ActiveSupport.version}
  MultiJson: #{MultiJson::VERSION}

MESSAGE

# Prepare data

DATA = Hash.new
key = 'aaa'
1000.times { DATA[key.succ!] = DATA.keys }
DATA.freeze

LOOP = 5
def loop_encoding
  LOOP.times { DATA.to_json }
end

# Benchmark

print 'before patch: '
puts(Benchmark.measure{ loop_encoding })

Rails::Patch::Json::Encode.patch_base_classes

print 'after patch:  '
puts(Benchmark.measure{ loop_encoding })
