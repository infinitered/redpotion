class Object
  def app
    rmq.app
  end

  alias :find :rmq
end

class UIView
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
    rmq(self).on(event, args, block)
  end

  def apply_style(style_name)
    rmq(self).apply_style(style_name)
  end

  def reapply_styles
    rmq(self).reapply_styles
  end

  def style(&block)
    rmq(self).style(block)
  end
end

class UIViewController
  def on_load
    # Abstract
  end
end

class ProMotion::Screen
  def append(view_or_constant, style=nil, opts = {})
    rmq(view).append(view_or_constant, style, opts)
  end
  def append!(view_or_constant, style=nil, opts = {})
    rmq(view).append!(view_or_constant, style, opts)
  end

  def prepend(view_or_constant, style=nil, opts = {})
    rmq(view).prepend(view_or_constant, style, opts)
  end
  def prepend!(view_or_constant, style=nil, opts = {})
    rmq(view).prepend!(view_or_constant, style, opts)
  end

  def create(view_or_constant, style=nil, opts = {})
    rmq(view).create(view_or_constant, style, opts)
  end
  def create!(view_or_constant, style=nil, opts = {})
    rmq(view).create!(view_or_constant, style, opts)
  end

  def build(view, style = nil, opts = {})
    rmq(view).build(view, style, opts)
  end
  def build!(view, style = nil, opts = {})
    rmq(view).build!(view, style, opts)
  end

  def reapply_styles
    rmq.all.reapply_styles
  end
end
