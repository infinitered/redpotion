Stylesheets are designed for a low memory footprint, fast startup, and fast operation. Most everything is done at compile-time, as it's all just ruby code. Low magic.

**They are called styles and stylesheets, but they are used for layout also. Basically if it changes the way a user sees something, it belongs in a stylesheet**.

* RedPotions's stylesheets are very simple, contain no (well, a little) magic, and are fast, as much as possible is done at compile time, not runtime
* As a styling and layout layer, it has the important features without sacrificing speed or simplicity
* You can style for different devices, device sizes, orientations, etc (see test app for an example of this)
* Exceptions tell you exactly where in your stylesheet the exception occurred

<a href="http://ir_wp.s3.amazonaws.com/wp-content/uploads/sites/19/2014/05/stylesheet_diagram_overview.png">

<img src="http://ir_wp.s3.amazonaws.com/wp-content/uploads/sites/19/2014/05/stylesheet_diagram_overview-1024x521.png" alt="stylesheet_diagram_overview" width="940" height="478" class="alignnone size-large wp-image-137" /></a>

* A style is simply a method in the stylesheet class. It is passed a styler
* You can apply a style to a view or views at anytime. They override existing settings

#### Apply a style when creating the view

```ruby
append UILabel, :title_label
```

#### Apply a style to existing views

```ruby
find(your_view, your_other_view).apply_style(:title_label)
```

#### Apply styles inline (you should use an existing style instead)

```ruby
def title_label(st)
  st.frame = {l: 10, t: 10, w: 200, h: 96}
  st.image = image.resource('logo')
end
```

Lots of methods exist for adding/building/adjusting views add styles.  You can apply a style in multiple locations.

![image](http://ir_wp.s3.amazonaws.com/wp-content/uploads/sites/19/2014/05/rmq.png)

#### Reapply styles - If your view updates

If a view has multiple styles applied to it and then you make some modifications to your view or screen, you can then call `reapply_styles` selected view(s) so that all styles will be reapplied again in the correct order from one simple method.  "Write once, reapply anytime!"

Most commonly used when new items are dynamically loaded, or if width/height of a view are changed (like on rotation).

```ruby
def will_animate_rotate(orientation, duration)
  reapply_styles
end
```

#### Layouts

Anything that can be applied using the grid or rect system (see Layout below). Can be applied with st.frame = 

```ruby
find(your_view).style do |st|
   st.frame = {grid: 'a1:c', h: 96}
end
```

#### Previous view

In addition to Layout's :below_prev, :right_of_prev, etc. You can get the previous frame and view like so:

```ruby
def foo(st)
   st.frame = {l: 10, t: st.prev_frame.top, w: 200, h: 96}
   st.text = st.prev_view.text
end
```

### A simple example of screen &amp; stylesheet

**home_screen.rb**

```ruby
class HomeScreen < PM::Screen
  title "RedPotion Rocks!"
  stylesheet HomeScreenStylesheet

  def on_load
    append UILabel, :title_label
    append UIImageView, :logo
  end
end
```

**home_screen_stylesheet.rb**

```ruby
class HomeScreenStylesheet < RubyMotionQuery::Stylesheet
  def root_view(st)
    st.background_color = color.white
  end

  def label(styler)
    styler.background_color = color.clear
  end

  def logo(st)
    st.frame = {t: 10, w: 200, h: 96, centered: :horizontal}
    st.image = image.resource('logo')
    st.view.someAttributeNotInStyler = 'foo'
  end

  def title_label(st)
    label st # combine 0 or more styles
    st.frame = {l: 5, below_prev: 5, w: 200, h: 20}
    st.text = 'Test label'
    st.color = color.from_hex('#3F3F3F')
  end
end
```

## Aplication stylesheet

You'll probably want an application-wide stylesheet. Simple create one, and then inherit it in all your stylesheets.

If you use potion to create your app, it will automatically create this for you. Even if you don't, I'd create a test app to see how it is all setup: `potion create test_app`

**application_stylesheet.rb**

```ruby
class ApplicationStylesheet < RubyMotionQuery::Stylesheet
  def label(styler)
    styler.background_color = color.clear
  end
end
```

**foo_stylesheet.rb**

```ruby
class FooStylesheet < ApplicationStylesheet
  def bar(st)
    ...
  end
end
```

*** Here is a longer example

```ruby
class ApplicationStylesheet < RubyMotionQuery::Stylesheet

  def application_setup

    # App grid, used by default throughout the applicaiton
    app.grid.tap do |g|
      g.content_left_margin = 10
      g.content_right_margin = 10
      g.content_top_margin = 74 
      g.content_bottom_margin = 10 
      g.num_columns =  12 
      g.column_gutter = 10 
      g.num_rows = 18 
      g.row_gutter = 10 
    end

    # Named fonts
    font_family = 'Helvetica Neue'
    font.add_named :very_large,     font_family, 56
    font.add_named :large,          font_family, 24 
    font.add_named :medium,         font_family, 18 
    font.add_named :standard,       font_family, 16 
    font.add_named :small,          font_family, 14 
    font.add_named :tiny,           font_family, 12 

    # Named colors
    color.add_named :tint, '#438AF0' 
    color.add_named :gray, '#DDDDDD' 
    color.add_named :light_gray, '#EDEDED' 
    color.add_named :very_light_gray,'#F4F4F4' 

    # Set other application-wide visual things, such as appearances:
    SVProgressHUD.appearance.hudBackgroundColor = color.light_gray
    SVProgressHUD.appearance.hudForegroundColor = color.black
  end

  # Some standard styles you can apply or use in other styles
  def standard_button(st)
    st.frame = {h: 30}
    st.background_color = color.tint
    st.color = color.white
    st.corner_radius = 5 
  end

  def standard_button_enabled(st)
    st.background_color = color.tint
    st.color = color.white
    st.enabled = true
  end

  def standard_button_disabled(st)
    st.background_color = color.gray
    st.color = color.white
    st.enabled = false
  end

  def shadow(st)
    st.clips_to_bounds = false
    st.view.layer.tap do |l|
      l.shadowColor = color.black.CGColor
      l.shadowOpacity = 0.2
      l.shadowRadius = 1.0
      l.shadowOffset = [0.5, 1.0]
    end
  end
end
```


## Example stylesheet

This stylesheet uses normal rect layout (left, right, etc). It could also be done using the grid.

I purposely used a variety of different things in this stylesheet to show different examples. In real life, I personally would use fr:, not from_right:. Both are fine, but I'd be consistent.

```ruby
class MainStylesheet < ApplicationStylesheet
  def setup
    # Add stylesheet specific setup stuff here.
    # Add application specific setup stuff in application_stylesheet.rb

    @padding = 10
  end

  def root_view(st)
    st.background_color = color.white
  end

  def logo(st)
    st.frame = {top: 77, width: 200, height: 95.5, centered: :horizontal }
    st.image = image.resource("logo")  # for logo@2x.png or logo.png
  end

  def make_labels_blink_button(st)
    st.frame = {fr: @padding, t: 180, w: 150, h: 20}
    # That is exactly the sames as st.frame = {from_right: @padding, top: 180, width: 150, height: 20}
    # Each frame/bounds hash option has an abbreviation

    # ipad? (and landscape?, etc) is just a convenience methods for
    # device.ipad?

    # Here is a complete example of different formatting for orientatinos
    # and devices
    #  if ipad?
    #    if landscape?
    #      st.frame = {l: 20, t: 120, w: 150, h: four_inch? ? 20 : 30}
    #    else
    #      st.frame = {l: 90, t: 120, w: 150, h: four_inch? ? 25 : 35}
    #    end
    #  else
    #    if landscape?
    #      st.frame = {l: 20, t: 20, w: 150, h: four_inch? ? 22 : 32}
    #    else
    #      st.frame = {l: 90, t: 20, w: 150, h: four_inch? ? 30 : 40}
    #    end
    #  end

    # If you don't want something to be reapplied when reapply_styles is called
    unless st.view_has_been_styled?
      st.text = "Blink labels"
      st.font = font.system(10)
      st.color = color.white

      # You can hardcode colors in styles like this, but it's better to use named colors
      st.background_color = color("ed1160") 
    end
  end

  def make_buttons_throb_button(st)
    st.frame = {from_right: @padding, below_prev: @padding, width: 150, height: 20}
    st.text = "Throb buttons"
    st.color = color.black
  end

  def animate_move_button(st)
    st.scale = 1.0
    st.frame = {fr: @padding, bp: 5, w: 150, h: 20}
    st.text = "Animate move and scale"
    st.font = font.system(10)
    st.color = color.white
    st.background_color = color("ed1160")
    st.z_position = 99
    st.color = color.white
  end

  def section(st)
    st.frame = {fb: @padding, w: 270, h: 110}

    st.frame = if landscape? && iphone?
      {left: @padding }
    else
      {centered: :horizontal}
    end

    st.z_position = 1
    st.background_color = color.battleship_gray # This is a named color
  end

  def section_label(st)
    label st # This is an example of calling a style that you created in the ApplicationStylesheet
    st.color = color.white
  end

  def popup_section(st)
    t = (landscape? && iphone?) ? 100 : 180
    st.frame = {l: @padding, t: t, w: 100 + (@padding * 2), h: 60}
    st.background_color = color.blue
  end

  def popup_text_label(st)
    label st # This is an example of calling a style that you created in the ApplicationStylesheet
    st.text_alignment = :left
    st.color = color.black
    st.font = font.system(10)
    st.text = "This is a Popup, woot!"

    # If the styler doesn't have the method, you can add it or
    # just use st.view to get the actual object
    st.view.lineBreakMode = NSLineBreakByWordWrapping
  end
end
```
