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

You can set `remote_image` to a URL string or an instance of `NSURL` and it will automatically fetch the image and set the image (with caching) using the power of [SDWebImage](https://github.com/rs/SDWebImage).

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

In order to use this feature, you must add the `SDWebImage` cocoapod to your project:

```ruby
app.pods do
  pod 'SDWebImage'
end
```

## New features for ProMotion

ProMotion 2.2.0 added on_styled and 2.3.0 added on_load to match RedPotion

### ProMotion::DataTableScreen

This is a feature that RubyMotion developers have wanted for some time now: easily binding a TableScreen to CoreData.

Now all you have to do is use [CDQ](https://github.com/infinitered/cdq) to define your CoreData schema and implement the model like so:

```ruby
schema "0001 initial" do
  entity "MyModel" do
    # Define anything you want to here
    string :name, optional: false
    integer32 :something_else, default: 5

    # These are special CDQ properties that get populated automatically.
    # They are not required, but are very helpful.
    datetime :created_at
    datetime :updated_at
  end
end
```

```ruby
class MyModel < CDQManagedObject
  # Scopes are optional
  scope :sort_name, sort_by(:name)

  # This is just a ProMotion TableScreen cell definition
  def cell
    # Use the model's properties to populate data in the hash
    {
      title: name,
      subtitle: "Something else: #{something_else}"
    }
  end
end
```

Then create you `DataTableScreen`:

```ruby
class SomeModelScreen < PM::DataTableScreen
  title "Cool Implementation of CoreData"
  model MyModel, scope: :sort_name
end
```

Once everything is in place, the new screen will mirror your CoreData database and build the cells based on the `cell` definition in the model. Whenever you update the data in CoreData the table will automatically update to reflect the new data! It automatically handles additions, deletions, and updates to existing model data.

The `model` class method accepts an optional `scope:` parameter where you an specify a scope as defined in your model. If you _do not_ specify a scope or the scope is not sorted, the `DataTableScreen` will attempt to sort your model data by the following properties (in this order): `:updated_at`, `:created_at`, `:id`.  If your model doesn't include any of these properties you should add a `sort_by(:property)` to the chosen scope or the DatTableScreen will not work.

**NOTE:** `DataTableScreen` is a work in progress and some of the extensions to `TableScreen` like `searchable`, `refreshable`, `longpressable`, etc. are not yet available.
