describe 'RubyMotionQuery ext' do
  it "should return the RMQ App when Object#app is called" do
    object = Object.new
    object.app.should.equal(RubyMotionQuery::App)
  end

  it "find should be an alias for rmq" do
    object = Object.new
    object.find.is_a?(RubyMotionQuery::RMQ).should.be.true
  end

  describe "UIView" do
    it "should call on_load instead of rmq_build if rmq_build does not exist in the view" do
      rmq.create(TestView).get.on_loaded.should == true

      test_view = TestView.alloc.initWithFrame([[0,0],[10,10]])
      test_view.on_loaded.should.be.nil
      rmq.build(test_view)
      test_view.on_loaded.should.be.true
    end

    it "should call on_styled instead of rmq_style_applied if rmq_style_applied does not exist in the view" do
      test_view = rmq.create!(TestView, :root_view)
      test_view.on_styled_fired.should.be.true
      test_view = TestView.alloc.initWithFrame([[0,0],[10,10]])
      test_view.on_styled_fired.should.be.nil
      test_view.apply_style(:root_view)
      test_view.on_styled_fired.should.be.true
    end

    describe "#append" do
      before { @view = UIView.alloc.init }

      it "should return a RMQ object" do
        appended = @view.append(UIView, nil, {})
        appended.is_a?(RubyMotionQuery::RMQ).should.be.true
      end

      it "should create a new object class provided" do
        appended = @view.append(UIView, nil, {})
        appended.get.is_a?(UIView).should.be.true
      end
    end

    describe "append!" do
      before { @view = UIView.alloc.init }

      it "should return the appended object" do
        appended = @view.append!(UIView, nil, {})
        appended.is_a?(UIView).should.be.true
      end
    end

    describe "prepend" do
      before { @view = UIView.alloc.init }

      it "should return a RMQ object" do
        prepended = @view.prepend(UIView, nil, {})
        prepended.is_a?(RubyMotionQuery::RMQ).should.be.true
      end

      it "should create a new object class provided" do
        prepended = @view.prepend(UIView, nil, {})
        prepended.get.is_a?(UIView).should.be.true
      end
    end

    describe "prepend!" do
      before { @view = UIView.alloc.init }

      it "should return the appended object" do
        prepended = @view.prepend!(UIView, nil, {})
        prepended.is_a?(UIView).should.be.true
      end
    end

    describe "create" do
      before { @view = UIView.alloc.init }

      it "should return a RMQ object" do
        created = @view.create(UIView, nil, {})
        created.is_a?(RubyMotionQuery::RMQ).should.be.true
      end

      it "should create a new object class provided" do
        created = @view.create(UIView, nil, {})
        created.get.is_a?(UIView).should.be.true
      end
    end

    describe "create!" do
      before { @view = UIView.alloc.init }

      it "should return the appended object" do
        created = @view.create!(UIView, nil, {})
        created.is_a?(UIView).should.be.true
      end
    end

    describe "build" do
      before { @view = UIView.alloc.init }

      it "should return a RMQ object" do
        built = @view.build(UIView, nil, {})
        built.is_a?(RubyMotionQuery::RMQ).should.be.true
      end

      it "should create a new object class provided" do
        built = @view.build(UIView, nil, {})
        built.get.is_a?(UIView).should.be.true
      end
    end

    describe "build!" do
      before { @view = UIView.alloc.init }

      it "should return the appended object" do
        built = @view.build!(UIView, nil, {})
        built.is_a?(UIView).should.be.true
      end
    end

    describe "on" do
      before do
        @button = UIButton.alloc.init
        @button.on(:tap, {}) { }
      end

      it "should attach the event" do
        @button.rmq_data.events.has_event?(:tap).should.be.true
      end
    end

    describe "apply_style" do
      class TestStylesheet
        def fake(st)
          st.text = 'style from sheet'
        end
      end

      before do
        @view = UILabel.alloc.init
        @view.rmq.stylesheet = TestStylesheet
        @view.apply_style(:fake)
      end

      it "should style the view" do
        @view.text.should.equal("style from sheet")
      end
    end

    describe "reapply_styles" do
      class TestStylesheet
        def fake(st)
          st.text = 'style from sheet'
        end
      end

      it "should reapply styles" do
        @view = rmq.append!(UILabel, :fake)
        @view.text.should.equal('style from sheet')

        @view.text = nil
        @view.text.should.be.nil

        @view.reapply_styles
        @view.text.should.equal('style from sheet')
      end
    end

    describe "style" do
      before do
        @view = UILabel.alloc.init

        @view.style do |st|
          st.text = "test style"
        end
      end

      it "should have styled the view" do
        @view.text.should.equal("test style")
      end
    end

    describe "color" do
      before { @view = UIView.alloc.init }

      it "should return rmq.color" do
        @view.color.should.equal(RubyMotionQuery::Color)
      end
    end

    describe "font" do
      before { @view = UIView.alloc.init }

      it "should return rmq.font" do
        @view.font.should.equal(RubyMotionQuery::Font)
      end
    end

    describe "image" do
      before { @view = UIView.alloc.init }

      it "should return rmq.image" do
        @view.image.should.equal(RubyMotionQuery::ImageUtils)
      end
    end

    describe "stylesheet" do
      before { @view = UIView.alloc.init }

      it "should return rmq.stylesheet" do
        @view.stylesheet.should.equal(@view.rmq.stylesheet)
      end
    end

    describe "stylesheet=" do
      before { @view = UIView.alloc.init }

      class FakeStylesheetForTest;end
      it "should set rmq.stylesheet" do
        @view.stylesheet = FakeStylesheetForTest
        @view.rmq.stylesheet.is_a?(FakeStylesheetForTest).should.be.true
      end
    end
  end

  describe "Promotion::Screen" do
    class TestScreenStylesheet < ApplicationStylesheet
      def root_view(st)
        st.background_color = color.white
      end
    end
    class TestScreen < PM::Screen
      stylesheet TestScreenStylesheet
    end

    before { @screen = TestScreen.new }

    describe "append" do
      it "should return a RMQ object" do
        appended = @screen.append(UIView, nil, {})
        appended.is_a?(RubyMotionQuery::RMQ).should.be.true
      end

      it "should create a new object class provided" do
        appended = @screen.append(UIView, nil, {})
        appended.get.is_a?(UIView).should.be.true
      end
    end

    describe "append!" do
      it "should return the appended object" do
        appended = @screen.append!(UIView, nil, {})
        appended.is_a?(UIView).should.be.true
      end
    end

    describe "prepend" do
      it "should return a RMQ object" do
        prepended = @screen.prepend(UIView, nil, {})
        prepended.is_a?(RubyMotionQuery::RMQ).should.be.true
      end

      it "should create a new object class provided" do
        prepended = @screen.prepend(UIView, nil, {})
        prepended.get.is_a?(UIView).should.be.true
      end
    end

    describe "prepend!" do
      it "should return the appended object" do
        prepended = @screen.prepend!(UIView, nil, {})
        prepended.is_a?(UIView).should.be.true
      end
    end

    describe "create" do
      it "should return a RMQ object" do
        created = @screen.create(UIView, nil, {})
        created.is_a?(RubyMotionQuery::RMQ).should.be.true
      end

      it "should create a new object class provided" do
        created = @screen.create(UIView, nil, {})
        created.get.is_a?(UIView).should.be.true
      end
    end

    describe "create!" do
      it "should return the appended object" do
        created = @screen.create!(UIView, nil, {})
        created.is_a?(UIView).should.be.true
      end
    end

    describe "build" do
      it "should return a RMQ object" do
        built = @screen.build(UIView, nil, {})
        built.is_a?(RubyMotionQuery::RMQ).should.be.true
      end

      it "should create a new object class provided" do
        built = @screen.build(UIView, nil, {})
        built.get.is_a?(UIView).should.be.true
      end
    end

    describe "build!" do
      it "should return the appended object" do
        built = @screen.build!(UIView, nil, {})
        built.is_a?(UIView).should.be.true
      end
    end

    describe "reapply_styles" do
      class TestStylesheet
        def root_view(st)
          st.background_color = UIColor.greenColor
        end
        def fake(st)
          st.text = 'style from sheet'
        end
      end

      it "should reapply styles" do
        TestScreen.stylesheet(TestStylesheet)
        @view = @screen.append!(UILabel, :fake)
        @view.text.should.equal('style from sheet')

        @view.text = nil
        @view.text.should.be.nil

        @screen.reapply_styles
        @view.text.should.equal('style from sheet')
      end
    end

    describe "color" do
      it "should return rmq.color" do
        @screen.color.should.equal(RubyMotionQuery::Color)
      end
    end

    describe "font" do
      it "should return rmq.font" do
        @screen.font.should.equal(RubyMotionQuery::Font)
      end
    end

    describe "image" do
      it "should return rmq.image" do
        @screen.image.should.equal(RubyMotionQuery::ImageUtils)
      end
    end

    describe "stylesheet" do
      it "should return rmq.stylesheet" do
        @screen.stylesheet.should.equal(@screen.rmq.stylesheet)
      end
    end

    describe "stylesheet=" do
      class FakeStylesheetForTest;end
      it "should set rmq.stylesheet" do
        @screen.stylesheet = FakeStylesheetForTest
        @screen.rmq.stylesheet.is_a?(FakeStylesheetForTest).should.be.true
      end
    end
  end
end
class TestView < UIView
  attr_reader :on_loaded
  attr_reader :on_styled_fired

  def on_load
    @on_loaded = true
  end

  def on_styled
    @on_styled_fired = true
  end
end
