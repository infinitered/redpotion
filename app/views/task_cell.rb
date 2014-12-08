class TaskCell < PM::TableViewCell
  def on_load
    apply_style :cell

    find(self.contentView).tap do |q|
      @title = q.append!(UILabel, :cell_title)
    end
  end

  def my_title=(value)
    @title.text = value
  end
end
