![image](http://ir_wp.s3.amazonaws.com/wp-content/uploads/sites/11/2014/11/logo_02.png)

# RedPotion

RedPotion combines [RMQ](http://rubymotionquery.com/), [ProMotion](https://github.com/clearsightstudio/ProMotion), [CDQ](https://github.com/infinitered/cdq), [AFMotion](https://github.com/clayallsopp/afmotion), and other libraries. It also adds new features to better integrate RMQ with ProMotion.

Its goals are to choose standard libraries and promote best practices, allowing you to develop iOS apps in record time.

=========

The **makers of RMQ** at [InfiniteRed](http://infinitered.com/) and the **creators of ProMotion** at [ClearSight Studio](https://clearsightstudio.com/) have teamed up to create the ultimate RubyMotion library.

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

Do **NOT** use RedPotion from github, we don't know why, but it will throw exceptions if you do; we're currently investigating why.


## New generators to integrate RMQ & ProMotion nicely ##

Our new generates allow you to create your ProMotion screen and stylesheet template to let you hit the ground running.  Currently the following RedPotion generators exist:

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


## New features for ProMotion

ProMotion 2.2.0 added on_load and on_styled to match RedPotion


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
