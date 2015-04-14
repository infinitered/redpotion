class Object
  def app
    rmq.app
  end

  def device
    rmq.device
  end

  def find(*args) # Do not alias this, strange bugs happen where classes don't have methods
    rmq(*args)
  end
end
