describe 'UIImageView' do
  it "should respond to remote_image" do
    UIImageView.new.should.respond_to?(:remote_image=)
  end
end
