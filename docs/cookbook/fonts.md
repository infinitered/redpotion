```ruby
font.family_list # useful in console
font.for_family('Helvetica') # useful in console

font.system(12)
font.font_with_name('Helvetica', 18)

# Add a new standard font (usually in ApplicationStylesheet.rb)
font_family = 'Helvetica Neue'
font.add_named :large, font_family, 36
font.add_named :medium, font_family, 24
font.add_named :small, font_family, 18

# then use them like so
font.large
font.small
```
