describe 'Object' do
  before { @subject = Object.new }

  it "should return the RMQ App when Object#app is called" do
    @subject.app.should.equal(RubyMotionQuery::App)
  end

  it "should return the RMQ Device when Object#device is called" do
    @subject.device.should.equal(RubyMotionQuery::Device)
  end

  it "find should be an alias for rmq" do
    @subject.find.is_a?(RubyMotionQuery::RMQ).should.be.true
  end

  it "should have access to the current screen" do
    controller = UIViewController.alloc.init
    controller.rmq.screen.should == controller
  end
end
