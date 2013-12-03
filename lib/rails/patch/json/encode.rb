require "rails/patch/json/encode/version"

# Use multi_json instead of Rails' to_json method (which calls ActiveSupport::JSON)
# when `render :json => @obj` is called.
module ActionController
  module Renderers
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
