module Rack
  #
  # A Rack middleware for automatically removing file extensions from URIs, and update the Accept HTTP Header accordingly.
  # 
  # e.g.:
  #   GET /some/resource.json HTTP/1.1
  #   Accept: */*
  # -> 
  #   GET /some/resource HTTP/1.1
  #   Accept: application/json, */*
  # 
  # You can add custom types with this kind of function (taken from sinatra):
  #   def mime(ext, type)
  #     ext = ".#{ext}" unless ext.to_s[0] == ?.
  #     Rack::Mime::MIME_TYPES[ext.to_s] = type
  #   end
  # then:
  #   mime :my_custom_extension_v1, 'application/vnd.com.example.MyCustomExtension+json;level=1'
  # results in the following behaviour:
  #   GET /some/resource.my_custom_extension_v1 HTTP/1.1
  #   Accept: */*
  # -> 
  #   GET /some/resource HTTP/1.1
  #   Accept: application/vnd.com.example.MyCustomExtension+json;level=1, */*
  # 
  class AcceptHeaderUpdater

    def initialize(app, options = {})
      @app = app
      @options = options
    end
  
    def call(env)
      req = Rack::Request.new(env)
      unless (ext = ::File.extname(req.path_info)).empty?
        ignore_middleware = (@options[:except] || []).detect{ |except| env['PATH_INFO'] =~ except }
        if !ignore_middleware && (mime_type = Rack::Mime::MIME_TYPES[ext.downcase])
          env['HTTP_ACCEPT'] = [mime_type, env['HTTP_ACCEPT']].join(",")
          req.path_info.gsub!(/#{ext}$/, '')
        end
      end
      @app.call(env)
    end    
  end
end