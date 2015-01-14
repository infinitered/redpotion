describe 'UIViewController' do
  module DelegateTestAttributes
    attr_accessor :view_did_load_count
    attr_accessor :view_will_appear_count

    def view_did_load
      self.view_did_load_count ||= 0
      self.view_did_load_count += 1
    end

    def view_will_appear(animated)
      self.view_will_appear_count ||= 0
      self.view_will_appear_count += 1
    end
  end
  class TestController < UIViewController; include DelegateTestAttributes; end
  class TestScreen < PM::Screen; include DelegateTestAttributes; end

  describe 'when using a PM::Screen' do
    tests TestScreen
    it 'should call view_will_appear only once' do
      controller.view_will_appear_count.should.equal(1)
    end

    it 'should call view_did_load only once' do
      controller.view_did_load_count.should.equal(1)
    end
  end

  describe 'when using a controller' do
    tests TestController
    it 'should call view_will_appear only once' do
      controller.view_did_load_count.should.equal(1)
    end
    it 'should call view_will_appear only once' do
      controller.view_will_appear_count.should.equal(1)
    end
  end
end
