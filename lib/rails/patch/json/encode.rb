require "rails/patch/json/encode/version"

# Code from http://devblog.agworld.com.au/post/42586025923/the-performance-of-to-json-in-rails-sucks-and-theres
# essentially reversing Rails' hard-coded call to ActiveSupport::JSON.encode
[Object, Array, FalseClass, Float, Hash, Integer, NilClass, String, TrueClass].each do |klass|
  klass.class_eval do
    def to_json(opts = {})
      MultiJson::dump(self, opts)
    end
  end
end
