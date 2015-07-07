describe "RubyMotionQuery styler: UIImageView" do
  extend WebStub::SpecHelpers

  before do
    WebStub::Protocol.disable_network_access!
  end
  after do
    WebStub::Protocol.enable_network_access!
  end

  it "should get text from test URL" do
    WebStub::API.stub_request(:get, "http://example.com/").
      to_return(body: "Hello!", content_type: "text/plain", delay: 0.3)

    app.net.get("http://example.com/") do |response|
      response.data.should == "Hello!"
    end
  end

  it "should get JSON from test URL" do
    #WebStub::API.stub_request(:get, "http://example.com/api/users/1?foo=123").
      #to_return(json: { name: "user 1" }, delay: 0.3)

    #app.net.get_json("http://example.com/api/users/1", foo: 123) do |response|
      #response.data.should == { name: "user 1" }
    #end
  end
end


