class <%= @name_camel_case %>Cell < UICollectionViewCell
  attr_reader :reused

  def on_load
    find(self).apply_style :<%= @name %>_cell

    q = find(self.contentView)
    # Add your subviews, init stuff here
    # @foo = q.append!(UILabel, :foo)
  end

  def prepareForReuse
    @reused = true
  end

end
