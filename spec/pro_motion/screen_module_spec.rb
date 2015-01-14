describe 'ScreenModule' do
  class TestScreenStylesheet < ApplicationStylesheet
    def root_view(st)
      st.background_color = color.white
    end
  end

  class TestScreen < PM::Screen
    stylesheet TestScreenStylesheet
  end

  tests TestScreen

  it "should set the rmq stylesheet" do
    controller.rmq.stylesheet.should.not.be.nil
  end

  describe "not providing a stylesheet" do
    class TestScreenTwo < PM::Screen; end

    it "should not raise exception if the stylesheet is not defined in the class" do
      should.not.raise(RuntimeError) do
        TestScreenTwo.new.view_did_load
      end
    end
  end
end
