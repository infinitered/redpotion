class UITableViewController
  # initWithStyle is called before viewDidLoad, if we use the stylesheet in
  # the table_data, we need to set the stylesheet earlier.
  alias :original_initWithStyle :initWithStyle

  def initWithStyle(style)
    # we need to set our stylesheet
    self.set_stylesheet

    self.original_initWithStyle(style)
  end
end

