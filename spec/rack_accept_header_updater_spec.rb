require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

def mime(ext, type)
  ext = ".#{ext}" unless ext.to_s[0] == ?.
  Rack::Mime::MIME_TYPES[ext.to_s] = type
end

describe Rack::AcceptHeaderUpdater do
  before(:each) do
    Rack::Mime::MIME_TYPES.clear
  end
  it "should add the correct mime type to the list of accepted types when a known extension is given" do
    mime :json, 'application/json'
    app = lambda { |env| [200, {'Content-Type' => 'text/plain'}, [[env['HTTP_ACCEPT'], env['PATH_INFO']].join("|")]] }
    request = Rack::MockRequest.env_for("/some/resource.json", :input => "foo=bar", 'HTTP_ACCEPT' => '*/*')
    status, headers, body = Rack::AcceptHeaderUpdater.new(app).call(request)
    body.should == ["application/json,*/*|/some/resource"]
  end
  it "should remove the file extension even if there are no mime types associated" do
    app = lambda { |env| [200, {'Content-Type' => 'text/plain'}, [[env['HTTP_ACCEPT'], env['PATH_INFO']].join("|")]] }
    request = Rack::MockRequest.env_for("/some/resource.json", :input => "foo=bar", 'HTTP_ACCEPT' => '*/*')
    status, headers, body = Rack::AcceptHeaderUpdater.new(app).call(request)
    body.should == ["*/*|/some/resource"]
  end
  it "should be case insensitive for extensions" do
    mime :json, 'application/json'
    app = lambda { |env| [200, {'Content-Type' => 'text/plain'}, [[env['HTTP_ACCEPT'], env['PATH_INFO']].join("|")]] }
    request = Rack::MockRequest.env_for("/some/resource.JSoN", :input => "foo=bar", 'HTTP_ACCEPT' => '*/*')
    status, headers, body = Rack::AcceptHeaderUpdater.new(app).call(request)
    body.should == ["application/json,*/*|/some/resource"]
  end
  it "should not modify the Accept Header if no extension is given" do
    app = lambda { |env| [200, {'Content-Type' => 'text/plain'}, [[env['HTTP_ACCEPT'], env['PATH_INFO']].join("|")]] }
    request = Rack::MockRequest.env_for("/some/resource", :input => "foo=bar", 'HTTP_ACCEPT' => 'application/json, */*')
    status, headers, body = Rack::AcceptHeaderUpdater.new(app).call(request)
    body.should == ["application/json, */*|/some/resource"]
  end
  it "should have no problem with complex mime types" do
    mime :collection_json_v1, 'application/vnd.com.example.Collection+json;level=1'
    app = lambda { |env| [200, {'Content-Type' => 'text/plain'}, [[env['HTTP_ACCEPT'], env['PATH_INFO']].join("|")]] }
    request = Rack::MockRequest.env_for("/some/resource.collection_json_v1", :input => "foo=bar", 'HTTP_ACCEPT' => '*/*')
    status, headers, body = Rack::AcceptHeaderUpdater.new(app).call(request)
    body.should == ["application/vnd.com.example.Collection+json;level=1,*/*|/some/resource"]
  end
end

