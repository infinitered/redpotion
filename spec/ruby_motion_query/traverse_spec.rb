describe 'RubyMotionQuery traverse' do
  it "should return the view_controller for screen" do
    rmq = RubyMotionQuery::RMQ.new

    rmq.screen.should.equal(rmq.view_controller)
  end
end
