# Colors

```ruby

color.red
color('#ffffff')
color('ffffff')
color(hex: '000', a: 0.5)
color(128, 128, 128, 0.5)
color(r: 128, g: 128, b: 128, a: 0.5)
color(red: 128, green: 128, blue: 128, alpha: 0.5)
color(h: 4, s: 3, b: 2, a: 1)

# Add a new standard color

color.add_named :pitch_black, '#000000'
# Or
color.add_named :pitch_black, color.black

# have color and you need to just adjust one of the values?
color(base: color.black, a: 0.5)

```

Color has a `with` method.  Allowing you to build a color from an existing color easily

```ruby
# For example that time you want your existing color, but with a slight change
color.my_custom_color.with(a: 0.5)
```

Added standard colors allow you to create your named colors, often in your app-wide `application_stylesheet.rb` or in any stylesheet's `application_setup` method, for easy use and single point of change.
