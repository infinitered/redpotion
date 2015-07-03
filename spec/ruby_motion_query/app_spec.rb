describe 'RubyMotionQuery app' do
  it "should return the current_view_controller for the current_screen" do
    expected = RubyMotionQuery::App.current_view_controller
    RubyMotionQuery::App.current_screen.should.equal(expected)
  end

  it "should retun cdq object when using app.data" do
    RubyMotionQuery::App.data.should == CDQ.cdq
  end
end
