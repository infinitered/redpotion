class Object
  def app
    rmq.app
  end

  def device
    rmq.device
  end

  def blank?
    self.respond_to?(:empty?) ? self.empty? : !self
  end

  def find(*args) # Do not alias this, strange bugs happen where classes don't have methods
    rmq(*args)
  end

  def find!(*args)
    rmq(*args).get
  end

  def screen
    rmq.screen
  end
end
