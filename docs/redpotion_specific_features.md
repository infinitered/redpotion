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
* `screen` aliases `rmq.view_controller`
* `live` aliases `rmq_live_stylesheets`
* `enable_live_stylesheets` aliases `enable_rmq_live_stylesheets`
* `on_load` aliases `rmq_build` in views. This is great as it now matches screens
* `on_styled` aliases `rmq_style_applied`
* `open` in the REPL aliases `find.screen.open(*)`
* `close` in the REPL aliases `find.screen.close(*)`

## append, create, build, on, off, apply_style, etc inside of a view

In RedPotion, if you call this inside of a custom view:

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
  # Scopes need to be sorted. We'll try and figure out how you
  # want it sorted automatically if it's not, and give you a
  # warning in the REPL.
  scope :sort_name, sort_by(:name)

  # This is just a ProMotion TableScreen cell definition.
  # All cell options are available here. See the PM docs for details.
  def cell
    {
      # Use the model's properties to populate data in the hash
      title: name,
      subtitle: "Something else: #{something_else}"
    }
  end
end
```

#### Then create your `DataTableScreen`

The `model` class method accepts an optional `scope:` parameter where you an specify a scope as defined in your model. If you _do not_ specify a scope or the scope is not sorted, the `DataTableScreen` will attempt to sort your model data by the following properties (in this order): `:updated_at`, `:created_at`, `:id`.  If your model doesn't include any of these properties you should add a `sort_by(:property)` to the chosen scope or the DataTableScreen will not work.

```ruby
class SomeModelScreen < PM::DataTableScreen
  title "Cool Implementation of CoreData"
  model MyModel, scope: :sort_name
end
```

You could also use a specific query like this:

```ruby
class SomeModelScreen < PM::DataTableScreen
  title "Cool Implementation of CoreData"
  # Tells DataTableScreen what cell definitions to use.
  model MyModel

  def model_query
    # You can use this space to return any CDQTargetedQuery
    # This is useful because you can use relationships here,
    # so long as the result contains all `MyModel` objects.
    MyModel.where(:name).contains("Emily")
      .and(:something_else).gt(4)
      .sort_by(:name)
  end
end
```

Once everything is in place, the new screen will mirror your CoreData database and build the cells based on the `cell` definition in the model. Whenever you update the data in CoreData the table will automatically update to reflect the new data! It automatically handles additions, deletions, and updates to existing model data.

#### Preserving MVC separation
You can also define the cell method on your DataTableScreen subclass, which enables you maintain traditional MVC separation when view-level information affects the cell definition.

```ruby
class MyTableScreen < PM::DataTableScreen

  def cell model
    {
      #Define cell appearance specific to the model instance
      cell_class: self.custom_cell_for model,
      # Use the model's properties to populate data in the hash
      title: model.name,
      subtitle: "Something else: #{something_else}"
    }
  end
end
```

