describe 'UIView' do
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

  describe "off" do
    before do
      @button = UIButton.alloc.init
      @button.on(:tap, {}) { }
      @button.on(:swipe, {}) { }
      @button.on(:value_changed, {}) { }
    end
    describe "removing a single event when many exist" do
      before do
        @button.off(:tap)
      end

      it "should detach the events" do
        @button.rmq_data.events.has_event?(:tap).should.be.false
        @button.rmq_data.events.has_event?(:swipe).should.be.true
        @button.rmq_data.events.has_event?(:value_changed).should.be.true
      end
    end
    describe "removing multiple events when many exist" do
      before do
        @button.off(:swipe, :value_changed)
      end

      it "should detach the events" do
        @button.rmq_data.events.has_event?(:tap).should.be.true
        @button.rmq_data.events.has_event?(:swipe).should.be.false
        @button.rmq_data.events.has_event?(:value_changed).should.be.false
      end
    end
  end

  describe "apply_style" do
    before do
      @view = UILabel.alloc.init
      @view.rmq.stylesheet = TestScreenStylesheet
      @view.apply_style(:test_label)
    end

    it "should style the view" do
      @view.text.should.equal("style from sheet")
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

    it "should set rmq.stylesheet" do
      @view.stylesheet = TestScreenStylesheet
      @view.rmq.stylesheet.is_a?(TestScreenStylesheet).should.be.true
    end
  end

  describe "find" do
    before do
      @view = UIView.alloc.init
      @view.append(UIButton)
    end

    it "should set use the proper context to find the children" do
      @view.find(UIButton).count.should.equal(1)
    end
  end
end
