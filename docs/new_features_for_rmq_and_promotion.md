# New generators to integrate RMQ & ProMotion nicely

Our new generators allow you to create your ProMotion screen and stylesheet template to let you hit the ground running.  Currently the following RedPotion generators exist:

```
potion create screen foo
potion create table_screen foo
potion create view foo

# All rmq generators work with the potion command as well
potion create model foo
potion create shared foo
potion create lib foo

# rmq controller generators also still exist
# but screens are preferred to get the redpotion value
potion create controller foo
potion create collection_view_controller foos
potion create table_view_controller bars

# RedPotion includes CDQ and afmotion by default, if you don't need these gems
# we have provided command line tasks to remove either of them
potion remove cdq
potion remove afmotion
```

## New features for RMQ

### `find` is aliased to `rmq` so you can use it for a more natural reading code:

```ruby
find.all.hide
find(my_view).children.nudge(right: 10)
```

### You can use `app` directly in code, which is the same as `rmq.app`

So you also get window, device, and delegate from that.

```
app.device
app.window
app.delegate
```

### You can use the following in a UIView or Screen or UIViewController without prefacing it with `rmq`:

```ruby
append
append!
prepend
prepend!
create
create!
build
build!
on
apply_style
reapply_styles
style
color
image
stylesheet
stylesheet=
```

### Stylesheet in your screens

You can specify the stylesheet in your screen like so:

```ruby
class HomeScreen < PM::Screen
  title "RedPotion"
  stylesheet HomeStylesheet

  def on_load
  end
end
```

### rmq_build can now be called on_load

You can use either rmq_build or on_load, they do exactly the same thing. You can only use one or the other. `on_load` is preferred as it matches the screen's onload.

```ruby
class Section < UIView
  def on_load
    apply_style :section

    append(UIButton, :section_button).on(:touch) do
      mp "Button touched"
    end
  end
end
```

### Remote image loading for UIImageView styler

You can set `remote_image` to a URL string or an instance of `NSURL` and it will automatically fetch the image and set the image (with caching) using the power of [JMImageCache](https://github.com/jakemarsh/JMImageCache).

```ruby
class MyStylesheet < ApplicationStylesheet
  def my_ui_image_view(st)
    # placeholder_image= is just an alias to image=
    # Set the placeholder image you want from your resources directory
    st.placeholder_image = image.resource("my_placeholder")
    # Set the remote URL. It will be applied to the UIImageView
    # when downloaded or retrieved from the local cache.
    st.remote_image = "http://www.rubymotion.com/img/rubymotion-logo.png"
    # or st.remote_image = NSURL.urlWithString(...)
  end
end
```

In order to use this feature, you must add the `JMIMageCache` cocoapod to your project:

```ruby
app.pods do
  pod 'JMImageCache'
end
```

## New features for ProMotion

ProMotion 2.2.0 added on_load and on_styled to match RedPotion

