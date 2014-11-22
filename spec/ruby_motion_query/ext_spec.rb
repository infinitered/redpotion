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
  end
end
