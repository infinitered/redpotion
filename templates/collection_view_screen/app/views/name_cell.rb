class <%= @name_camel_case %>Cell < UICollectionViewCell
  def on_load
    find(self).apply_style :<%= @name %>_cell

    q = find(self.contentView)
    # Add your subviews, init stuff here
    # @foo = q.append!(UILabel, :foo)
  end
end
