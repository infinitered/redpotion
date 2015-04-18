# Updating data or attributes

RedPotion provides a variety of ways to update a view's data or attributes. All of which are chain-able.

### Data

You can use **.data** to either set or retrieve the "data" of the selected views. Depending on the view type, it will be the most common attribute, such as .text for UITextField or .image for UIImageView.

To set the data, you can do this

```ruby
find(my_text_field).data('Foo')
find(my_label).data('Bar')
```

To get the data:

```ruby
find(my_text_field).data
=> 'Foo'

# Returns an array if more than one view is selected
find(UIView).data
=> ['Foo', 'Bar']
```

This is chain-able. For example, let's say you need to set a label's title before applying a style, you could do this:

```ruby
find.append(UILabel).data('Some long title').apply_style(:name_label)
```

You also use an **=** like so, but it's not chain-able:

```ruby
find(my_text_field).data = 'foo'
```

### Attr

You can set any attribute:

```ruby
find(my_text_field).attr(text: 'Foo')
```

### Worse case scenario, you can use send:

```ruby
find(UILabel).send(:some_method, args)
```
