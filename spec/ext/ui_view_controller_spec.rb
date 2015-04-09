describe 'UIViewController' do
  shared 'proper delegate caller' do
    it 'should call view_will_appear only once' do
      controller.view_will_appear_count.should.equal(1)
    end

    it 'should call view_did_appear only once' do
      controller.viewDidAppear(true)

      controller.view_did_appear_count.should.equal(1)
    end

    it 'should call view_did_load only once' do
      controller.view_did_load_count.should.equal(1)
    end

    it 'should call view_will_disappear only once' do
      controller.viewWillDisappear(true)

      controller.view_will_disappear_count.should.equal(1)
    end

    it 'should call view_will_disappear only once' do
      controller.viewDidDisappear(true)

      controller.view_did_disappear_count.should.equal(1)
    end
  end

  describe 'when using a PM::Screen' do
    tests TestScreen

    behaves_like 'proper delegate caller'

    describe 'append' do
      it "should return a RMQ object" do
        appended = controller.append(UIView, nil, {})
        appended.is_a?(RubyMotionQuery::RMQ).should.be.true
      end

      it "should create a new object class provided" do
        appended = controller.append(UIView, nil, {})
        appended.get.is_a?(UIView).should.be.true
      end
    end

    describe "append!" do
      it "should return the appended object" do
        appended = controller.append!(UIView, nil, {})
        appended.is_a?(UIView).should.be.true
      end
    end

    describe "prepend" do
      it "should return a RMQ object" do
        prepended = controller.prepend(UIView, nil, {})
        prepended.is_a?(RubyMotionQuery::RMQ).should.be.true
      end

      it "should create a new object class provided" do
        prepended = controller.prepend(UIView, nil, {})
        prepended.get.is_a?(UIView).should.be.true
      end
    end

    describe "prepend!" do
      it "should return the appended object" do
        prepended = controller.prepend!(UIView, nil, {})
        prepended.is_a?(UIView).should.be.true
      end
    end

    describe "create" do
      it "should return a RMQ object" do
        created = controller.create(UIView, nil, {})
        created.is_a?(RubyMotionQuery::RMQ).should.be.true
      end

      it "should create a new object class provided" do
        created = controller.create(UIView, nil, {})
        created.get.is_a?(UIView).should.be.true
      end
    end

    describe "create!" do
      it "should return the appended object" do
        created = controller.create!(UIView, nil, {})
        created.is_a?(UIView).should.be.true
      end
    end

    describe "build" do
      it "should return a RMQ object" do
        built = controller.build(UIView, nil, {})
        built.is_a?(RubyMotionQuery::RMQ).should.be.true
      end

      it "should create a new object class provided" do
        built = controller.build(UIView, nil, {})
        built.get.is_a?(UIView).should.be.true
      end
    end

    describe "build!" do
      it "should return the appended object" do
        built = controller.build!(UIView, nil, {})
        built.is_a?(UIView).should.be.true
      end
    end

    describe "color" do
      it "should return rmq.color" do
        controller.color.should.equal(RubyMotionQuery::Color)
      end
    end

    describe "font" do
      it "should return rmq.font" do
        controller.font.should.equal(RubyMotionQuery::Font)
      end
    end

    describe "image" do
      it "should return rmq.image" do
        controller.image.should.equal(RubyMotionQuery::ImageUtils)
      end
    end

    describe "stylesheet" do
      it "should return rmq.stylesheet" do
        controller.stylesheet.should.equal(controller.rmq.stylesheet)
      end
    end

    describe "stylesheet=" do
      it "should set rmq.stylesheet" do
        controller.stylesheet = TestScreenStylesheet
        controller.rmq.stylesheet.is_a?(TestScreenStylesheet).should.be.true
      end
    end

    describe "reapply_styles" do
      it "should reapply styles" do
        @view = controller.append!(UILabel, :test_label)
        @view.text.should.equal('style from sheet')

        @view.text = nil
        @view.text.should.be.nil

        controller.reapply_styles
        @view.text.should.equal('style from sheet')
      end
    end

    describe "find" do
      it "should set use the proper context to find the children" do
        controller.append(UILabel).tag(:find_me)
        controller.find(:find_me).count.should.equal(1)
      end
    end
  end

  describe 'when using a controller' do
    tests TestController

    behaves_like 'proper delegate caller'
  end
end
