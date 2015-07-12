# Features we've added to RedPotion that don't modify an existing gem

This isn't a complete list, but here are some highlights. See the specific sections in the cookbook for everything.

## UIColor

UIColor has a `with` method.  Allowing you to build a color from an existing color easily

```ruby
# for example that time you want your existing color, but with a slight change
color.my_custom_color.with(a: 0.5)
```

## remote_image

See "Images, icons, and photos" in cookbook

## blank?

```
nil.blank? => true
[].blank? => true
{}.blank? => true
# etc
```

## Semantic methods

* `app` aliases `rmq.app`
* `device` aliases `rmq.device`
* `find` aliases `rmq` so you can do stuff like: `find(:some_style).find(UIButton).hide`
* `app.data` aliases cdq.
* `find.screen` aliases `rmq.view_controller`
* `live` aliases `rmq_live_stylesheets`
* `enable_live_stylesheets` aliases `enable_rmq_live_stylesheets`
* `on_load` aliases `rmq_build` in views. This is great as it now matches screens
* `on_styled` aliases `rmq_style_applied`

## append, create, build, on, off, apply_style, etc inside of a view

I RedPotion, if you call this inside of a custom view:

```
append(UIView)
```

That is the same as calling:

```
rmq(self).append(UIView)
```

This is true for all these:

* append
* create
* build
* append!
* create!
* build!
* on
* off
* apply_style
* reapply_styles
* style
* color
* font
* image

## ProMotion::DataTableScreen

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
