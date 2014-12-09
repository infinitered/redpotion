class Object
  def app
    rmq.app
  end

  def find(*args) # Do not alias this, strange bugs happen where classes don't have methods
    rmq(args)
  end
end

class UIView
  # You can use either rmq_build or on_load, not both. If you have both, on_load will be ignored,
  # you can however call it from rmq_build. They are the same, on_load follows the ProMotion style
  # and is recommended.
  def rmq_build
    on_load
  end

  def on_load
  end

  def on_styled
  end

  # You can user either rmq_style_applied or on_styled, not both.  If you have both on_styled will be ignored,
  # you can however call it from rmq_style_applied.  They are the same, on_styled follows the Promotion style
  # and is recommended.
  def rmq_style_applied
    on_styled
  end

  def append(view_or_constant, style=nil, opts = {})
    rmq(self).append(view_or_constant, style, opts)
  end
  def append!(view_or_constant, style=nil, opts = {})
    rmq(self).append!(view_or_constant, style, opts)
  end

  def prepend(view_or_constant, style=nil, opts = {})
    rmq(self).prepend(view_or_constant, style, opts)
  end
  def prepend!(view_or_constant, style=nil, opts = {})
    rmq(self).prepend!(view_or_constant, style, opts)
  end

  def create(view_or_constant, style=nil, opts = {})
    rmq(self).create(view_or_constant, style, opts)
  end
  def create!(view_or_constant, style=nil, opts = {})
    rmq(self).create!(view_or_constant, style, opts)
  end

  def build(view, style = nil, opts = {})
    rmq(self).build(view, style, opts)
  end
  def build!(view, style = nil, opts = {})
    rmq(self).build!(view, style, opts)
  end

  def on(event, args = {}, &block)
    rmq(self).on(event, args, &block)
  end

  def apply_style(style_name)
    rmq(self).apply_style(style_name)
  end

  def reapply_styles
    rmq(self).reapply_styles
  end

  def style(&block)
    rmq(self).style(&block)
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
end
class UIViewController
  def on_load
  end

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

  def view_did_load
  end

  def viewDidLoad
    if self.class.rmq_style_sheet_class
      self.rmq.stylesheet = self.class.rmq_style_sheet_class
      self.view.rmq.apply_style :root_view
    end
    self.view_did_load unless pm_handles_did_load?
  end

  def pm_handles_did_load?
    self.is_a?(ProMotion::ViewController) || self.is_a?(ProMotion::TableScreen)
  end

  def view_will_appear(animated)
  end
  def viewWillAppear(animated)
    self.view_will_appear(animated)
  end

  def view_did_appear(animated)
  end
  def viewDidAppear(animated)
    self.view_did_appear(animated)
  end

  def view_will_disappear(animated)
  end
  def viewWillDisappear(animated)
    self.view_will_disappear(animated)
  end

  def view_did_disappear(animated)
  end
  def viewDidDisappear(animated)
    self.view_did_disappear(animated)
  end

  def should_rotate(orientation)
  end
  def shouldAutorotateToInterfaceOrientation(orientation)
    self.should_rotate(orientation)
  end

  def should_autorotate
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
end
