class ContributerCell < ProMotion::TableViewCell
  def on_load
    apply_style :cell

    find(self.contentView).tap do |q|
      @title = q.append!(UILabel, :cell_title)
      @button = q.append!(UIButton, :github_button)
    end
  end

  def name=(value)
    @title.text = value
    # TODO: this is being called twice for each cell...
    @button.off.on(:tap) do
      url = NSURL.URLWithString("http://www.github.com/#{value}")
      UIApplication.sharedApplication.openURL(url)
    end
  end
end
