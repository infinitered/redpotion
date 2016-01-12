module DelegateTestAttributes
  
  attr_accessor :view_did_load_count
  attr_accessor :view_will_appear_count
  attr_accessor :view_did_appear_count
  attr_accessor :view_will_disappear_count
  attr_accessor :view_did_disappear_count

  def view_did_load
    self.view_did_load_count ||= 0
    self.view_did_load_count += 1
  end

  def view_will_appear(animated)
    self.view_will_appear_count ||= 0
    self.view_will_appear_count += 1
  end

  def view_did_appear(animated)
    self.view_did_appear_count ||= 0
    self.view_did_appear_count += 1
  end

  def view_will_disappear(animated)
    self.view_will_disappear_count ||= 0
    self.view_will_disappear_count += 1
  end

  def view_did_disappear(animated)
    self.view_did_disappear_count ||= 0
    self.view_did_disappear_count += 1
  end
  
end
