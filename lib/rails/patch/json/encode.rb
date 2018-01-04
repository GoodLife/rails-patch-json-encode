require "rails/patch/json/encode/version"
require 'multi_json'

module Rails::Patch::Json::Encode
  # Use multi_json instead of Rails' to_json method (which calls ActiveSupport::JSON)
  # when `render :json => @obj` is called.
  def self.patch_renderers
    ::ActionController::Renderers.module_eval do
      # Override
      add :json do |json, options|
        json = MultiJson::dump(json.as_json(options), options) unless json.kind_of?(String)

        if options[:callback].present?
          self.content_type ||= Mime::JS
          "#{options[:callback]}(#{json})"
        else
          self.content_type ||= Mime::JSON
          json
        end
      end
    end
  end



  # Combine http://devblog.agworld.com.au/post/42586025923/the-performance-of-to-json-in-rails-sucks-and-theres
  # and Rails' ToJsonWithActiveSupportEncoder together,
  # essentially reversing Rails' hard-coded call to ActiveSupport::JSON.encode
  module ToJsonWithMultiJson
    def to_json(options = {})
      if options.is_a?(::JSON::State)
        super(options)
      else
        ::MultiJson::dump(self.as_json(options), options)
      end
    end
  end

  def self.patch_base_classes
    [Object, Array, FalseClass, Float, Hash, Integer, NilClass, String, TrueClass, Enumerable].reverse_each do |klass|
      klass.prepend(ToJsonWithMultiJson)
    end
  end
end
