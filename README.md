![image](http://ir_public.s3.amazonaws.com/projects/redpotion/RedPotion_logo_transparent.png)

# RedPotion
[![Build Status](https://travis-ci.org/infinitered/redpotion.svg?branch=master)](https://travis-ci.org/infinitered/redpotion)

We believe iPhone development should be clean, scalable, and fast with a language that developers not only enjoy, but actively choose.  With the advent of Ruby for iPhone development the RubyMotion community has combined and tested the most active and powerful gems into a single package called **RedPotion**

RedPotion combines [RMQ](http://rubymotionquery.com/), [ProMotion](https://github.com/clearsightstudio/ProMotion), [CDQ](https://github.com/infinitered/cdq), [AFMotion](https://github.com/clayallsopp/afmotion), [MotionPrint](https://github.com/OTGApps/motion_print) and [MORE!](#full-listing-of-gems-and-pods-for-redpotion). It also adds new features to better integrate RMQ with ProMotion.  The goal is simply to choose standard libraries and promote best practices, allowing you to develop iOS apps in record time.

=========

## Read the [documentation](http://redpotion.readthedocs.org/en/latest) [here](http://redpotion.readthedocs.org/en/latest)


The **makers of RMQ** at [InfiniteRed](http://infinitered.com/) and the **creators of ProMotion** at [ClearSight](https://clearsightstudio.com/) as well as [David Larrabee](https://twitter.com/Squidpunch) have teamed up to create the ultimate RubyMotion library.

[![image](https://ir_wp.s3.amazonaws.com/wp-content/uploads/sites/11/2013/08/InfiniteRed_logo_100h.png)](http://infinitered.com/) &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; [![image](https://clearsightstudio.com/assets/images/clearsight-logos/color-logo@2x-458a9655.png)](https://clearsightstudio.com/)

ProMotion for screens and RMQ for styles, animations, traversing, events, etc.

## Plugins and Add-ons

You can use both RMQ Plugins and ProMotion Add-ons

![image](https://camo.githubusercontent.com/523372b371be1de2fb2cec421be423e2b89bcfd0/687474703a2f2f69725f77702e73332e616d617a6f6e6177732e636f6d2f77702d636f6e74656e742f75706c6f6164732f73697465732f31392f323031342f30392f726d715f706c7567696e2e706e67)

![image](http://ir_wp.s3.amazonaws.com/wp-content/uploads/sites/11/2014/11/ProMotion-addon-logo.png)


## Quick start

```
gem install redpotion

potion create my_app
bundle
rake pod:install
rake
```

## Installation

- `gem install redpotion`

If you use rbenv

- `rbenv rehash`

add it to your `Gemfile`:

- `gem 'redpotion'`


## Let's build something

Let's start by creating our app, do this:

```
> potion create myapp
> cd myapp
> bundle
> rake pod:install
> rake
```

Your app should be running now. Type `exit` in console to stop your app.

Let's add a text field, a button, and an image to the main screen:

Open the `home_screen.rb` file, then add this

```ruby
@image_url = append!(UITextField, :image_url)

append UIButton, :go_button

@sample_image = append!(UIImageView, :sample_image)
```

Delete this line:

```ruby
@hello_world = append!(UILabel, :hello_world)
```

Now we need to style them so you can see them on your screen.

Open up `home_screen_stylesheet.rb`, then add this:

```ruby
def image_url(st)
  st.frame = {left: 20, from_right: 20, top: 80, height: 30}
  st.background_color = color.light_gray
end

def go_button(st)
  st.frame = {below_prev: 10, from_right: 20, width: 40, height: 30}
  st.text = "go"
  st.background_color = color.blue
  st.color = color.white
end

def sample_image(st)
  st.frame = {left: 20, below_prev: 10, from_right: 20, from_bottom: 20}
  st.background_color = color.gray

  # an example of using the view directly
  st.view.contentMode = UIViewContentModeScaleAspectFit
end
```

Now let's add the logic. When the user enters a URL to an image in the text field, then tap **Go**, it shows the picture in the image view below.

Let's add the event to the go_button:

Replace this:
```ruby
append UIButton, :go_button
```

With this:
```ruby
append(UIButton, :go_button).on(:touch) do |sender|
  @sample_image.remote_image = @image_url.text
  @image_url.resignFirstResponder # Closes keyboard
end
```

You should end up with this `on_load` method:

```ruby
def on_load
  set_nav_bar_button :left, system_item: :camera, action: :nav_left_button
  set_nav_bar_button :right, title: "Right", action: :nav_right_button

  @image_url = append!(UITextField, :image_url)

  append(UIButton, :go_button).on(:touch) do |sender|
    @sample_image.remote_image = @image_url.text
    @image_url.resignFirstResponder # Closes keyboard
  end

  @sample_image = append!(UIImageView, :sample_image)
end
```

Now paste this URL in and hit **Go**
`http://bit.ly/18iMhwc`

You should have this:

![image](http://ir_wp.s3.amazonaws.com/wp-content/uploads/sites/11/2015/03/myapp_screenshot.jpg)

## Live stylesheet reloading

In REPL, type: `live`

![image](http://clrsight.co/jh/LiveReload4.gif?+)

## New generators to integrate RMQ & ProMotion nicely ##

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

In order to use this feature, you must add the `JMIMageCache` cocoapod to your project (this is included in a new project):

```ruby
app.pods do
  pod 'JMImageCache'
end
```

## New features for ProMotion

ProMotion 2.2.0 added on_load and on_styled to match RedPotion

## RedPotion specific features

UIColor has a `with` method.  Allowing you to build a color from an existing color easily

```ruby
# for example that time you want your existing color, but with a slight change
color.my_custom_color.with(a: 0.5)
```

PM::DataTableScreen - added a clean way to integrate a table screen with a custom cell, and data backed model

```ruby
class ContributerScreen < PM::DataTableScreen
  title "RedPotion Contributers"
  refreshable
  stylesheet ContributerScreenStylesheet
  model Contributer
end

class Contributer < CDQManagedObject
  def cell
    {
      cell_class: ContributerCell,
      properties: {
        name: name
      }
    }
  end
end

class ContributerCell < ProMotion::TableViewCell
  def on_load
    apply_style :cell

    find(self.contentView).tap do |q|
      @title = q.append!(UILabel, :cell_title)
    end
  end

  def name=(value)
    @title.text = value
  end
end
```

## Full listing of Gems and Pods for RedPotion
**Gems**
* [RMQ](http://rubymotionquery.com/)
* [ProMotion](https://github.com/clearsightstudio/ProMotion)
* [CDQ](https://github.com/infinitered/cdq)
* [AFMotion](https://github.com/clayallsopp/afmotion)
* [motion_print](https://github.com/OTGApps/motion_print)
* [motion-cocoapods](https://github.com/HipByte/motion-cocoapods)
* (DEV) [webstub](https://github.com/nathankot/webstub)
* (DEV) [newclear](https://github.com/IconoclastLabs/newclear)

**Pods**
* [JMImageCache](https://github.com/jakemarsh/JMImageCache)

## Contributing

0. Create an issue in GitHub to make sure your PR will be accepted.
1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request


## Read the [documentation](http://redpotion.readthedocs.org/en/latest) [here](http://redpotion.readthedocs.org/en/latest)
