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

  def off(*events)
    rmq(self).off(*events)
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
