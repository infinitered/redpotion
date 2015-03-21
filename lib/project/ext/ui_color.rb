class UIColor
  def with(options)
    begin
      r, g, b, a = Pointer.new('d'), Pointer.new('d'), Pointer.new('d'), Pointer.new('d')
      self.getRed(r, green: g, blue: b, alpha: a)
    rescue
      r, g, b, a = Pointer.new('f'), Pointer.new('f'), Pointer.new('f'), Pointer.new('f')
      self.getRed(r, green: g, blue: b, alpha: a)
    end

    r = options[:r] || options[:red] || r.value
    g = options[:g] || options[:green] || g.value
    b = options[:b] || options[:blue] || b.value
    a = options[:a] || options[:alpha] || a.value

    UIColor.colorWithRed(r, green: g, blue: b, alpha: a)
  end
end
