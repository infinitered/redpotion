There are two types of templates in RedPotion for tables:

* Metal tables: "Metal" meaning down to the metal. These are standard SDK tables, that are converted into ProMotion screens
* ProMotion tables: These are easy to use and if you don't have tons of rows they would be a good choice.

## Metal tables

### To create

```
potion g table_screen foo
```

## ProMotion tables (Table Screen)

ProMotion::TableScreen allows you to easily create lists or "tables" as iOS calls them. It's a subclass of [UITableViewController](http://developer.apple.com/library/ios/#documentation/uikit/reference/UITableViewController_Class/Reference/Reference.html) and has all the goodness of [PM::Screen](https://github.com/infinitered/ProMotion/blob/master/docs/Reference/ProMotion%20Screen.md) with some additional magic to make the tables work beautifully.

|Table Screens|Grouped Tables|Searchable|Refreshable|
|---|---|---|---|
|![ProMotion TableScreen](https://f.cloud.github.com/assets/1479215/1534137/ed71e864-4c90-11e3-98aa-ed96049f5407.png)|![Grouped Table Screen](https://f.cloud.github.com/assets/1479215/1589973/61a48610-5281-11e3-85ac-abee99bf73ad.png)|![Searchable](https://f.cloud.github.com/assets/1479215/1534299/20cc05c6-4c93-11e3-92ca-9ee39c044457.png)|![Refreshable](https://f.cloud.github.com/assets/1479215/1534317/5a14ef28-4c93-11e3-8e9e-f8c08d8464f8.png)|

### To create

```
potion g table_screen foo
```

[ProMotion table docs](https://github.com/infinitered/ProMotion/blob/master/docs/Reference/ProMotion%20TableScreen.md)


### Add a custom cell

We almost always use custom cells, rather than rely on the default ones provided by the SDK. To create a custom cell (or many different cell types) for your table screen, do this:

```
potion g table_screen_cell bar_cell
```

Then follow the directions in the files that were created.

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
