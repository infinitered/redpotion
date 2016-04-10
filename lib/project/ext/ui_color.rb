class UIColor
  
  def with(options)
    type = CGSize.type[/(f|d)/]
    r, g, b, a = Pointer.new(type), Pointer.new(type), Pointer.new(type), Pointer.new(type)
    self.getRed(r, green: g, blue: b, alpha: a)

    r = options[:r] || options[:red] || r.value
    g = options[:g] || options[:green] || g.value
    b = options[:b] || options[:blue] || b.value
    a = options[:a] || options[:alpha] || a.value

    UIColor.colorWithRed(r, green: g, blue: b, alpha: a)
  end
  
end
