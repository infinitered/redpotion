class UIViewController
  def append(view_or_constant, style=nil, opts = {})
    view.append(view_or_constant, style, opts)
  end
  def append!(view_or_constant, style=nil, opts = {})
    view.append!(view_or_constant, style, opts)
  end

  def prepend(view_or_constant, style=nil, opts = {})
    view.prepend(view_or_constant, style, opts)
  end
  def prepend!(view_or_constant, style=nil, opts = {})
    view.prepend!(view_or_constant, style, opts)
  end

  def create(view_or_constant, style=nil, opts = {})
    view.create(view_or_constant, style, opts)
  end
  def create!(view_or_constant, style=nil, opts = {})
    view.create!(view_or_constant, style, opts)
  end

  def build(view_or_constant, style = nil, opts = {})
    view.build(view_or_constant, style, opts)
  end
  def build!(view_or_constant, style = nil, opts = {})
    view.build!(view_or_constant, style, opts)
  end

  def reapply_styles
    rmq.all.reapply_styles
  end

  def color
    rmq.color
  end

  def font
    rmq.font
  end

  def image
    rmq.image
  end

  def stylesheet
    rmq.stylesheet
  end

  def stylesheet=(value)
    rmq.stylesheet = value
  end

  def self.stylesheet(style_sheet_class)
    @rmq_style_sheet_class = style_sheet_class
  end

  def self.rmq_style_sheet_class
    @rmq_style_sheet_class
  end

  def on_load
  end

  def view_did_load
  end

  # Monkey patch because I think that overriding viewDidLoad like this may be problematic
  alias :originalViewDidLoad :viewDidLoad
  def viewDidLoad
    if self.class.rmq_style_sheet_class
      self.rmq.stylesheet = self.class.rmq_style_sheet_class
      self.view.rmq.apply_style(:root_view) if self.rmq.stylesheet.respond_to?(:root_view)
    end

    self.originalViewDidLoad
    unless pm_handles_delegates?
      unless self.class.included_modules.include?(ProMotion::ScreenModule)
        self.view_did_load
      end
      self.on_load
    end
  end

  def view_will_appear(animated)
  end

  def viewWillAppear(animated)
    unless pm_handles_delegates?
      self.view_will_appear(animated)
    end
  end

  def view_did_appear(animated)
  end

  def viewDidAppear(animated)
    unless pm_handles_delegates?
      self.view_did_appear(animated)
    end
  end

  def view_will_disappear(animated)
  end

  def viewWillDisappear(animated)
    unless pm_handles_delegates?
      self.view_will_disappear(animated)
    end
  end

  def view_did_disappear(animated)
  end

  def viewDidDisappear(animated)
    unless pm_handles_delegates?
      self.view_did_disappear(animated)
    end
  end

  def should_rotate(orientation)
  end

  def shouldAutorotateToInterfaceOrientation(orientation)
    self.should_rotate(orientation)
  end

  def should_autorotate
    true
  end

  def shouldAutorotate
    self.should_autorotate
  end

  def will_rotate(orientation, duration)
  end

  def willRotateToInterfaceOrientation(orientation, duration:duration)
    self.will_rotate(orientation, duration)
  end

  def on_rotate(orientation)
  end

  def didRotateFromInterfaceOrientation(orientation)
    self.on_rotate orientation
  end

  def will_animate_rotate(orientation, duration)
  end

  def willAnimateRotationToInterfaceOrientation(orientation, duration: duration)
    self.will_animate_rotate(orientation, duration)
  end

  private

  def pm_handles_delegates?
    self.is_a?(ProMotion::ViewController) || self.is_a?(ProMotion::TableViewController)
  end
end
