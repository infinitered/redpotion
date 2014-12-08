class MetalTableCell < UITableViewCell
  def on_load
    find(self.contentView).tap do |q|
      @name = q.append!(UILabel, :cell_name)
    end
  end

  def update(data)
    @name.text = "#{data[:name]} is #{data[:num]}"
  end
end
