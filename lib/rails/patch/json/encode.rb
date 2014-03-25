require "rails/patch/json/encode/version"

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

  # Code from http://devblog.agworld.com.au/post/42586025923/the-performance-of-to-json-in-rails-sucks-and-theres
  # essentially reversing Rails' hard-coded call to ActiveSupport::JSON.encode
  def self.patch_base_classes
    [Object, Array, FalseClass, Float, Hash, Integer, NilClass, String, TrueClass].each do |klass|
      klass.class_eval do
        def to_json(opts = {})
          MultiJson::dump(self.as_json(opts), opts)
        end
      end
    end
  end
end
