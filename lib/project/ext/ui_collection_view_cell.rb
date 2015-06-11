class UICollectionViewCell
  attr_accessor :collection_screen

  # You can use either rmq_build or on_load, not both. If you have both, on_load will be ignored,
  # you can however call it from rmq_build. They are the same, on_load follows the ProMotion style
  # and is recommended.
  def rmq_build
    self.on_load
  end

  def reused
    @reused
  end

  def prepareForReuse
    super
    @reused = true
  end
end
