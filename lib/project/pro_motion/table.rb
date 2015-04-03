module ProMotion
  class TableScreen < TableViewController
    # For some reason, this empty class definition is required
    # or we get a NoMethodError with the `searchable`
    # class method call. O_o
  end
end
