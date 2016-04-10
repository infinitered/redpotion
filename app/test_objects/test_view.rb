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
