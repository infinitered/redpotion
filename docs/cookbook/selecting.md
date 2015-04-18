# Selecting or finding views

You can select a view using the following:

* Constant
* :a_tag
* :a_style_name
* my_view_instance
* text: 'you can select via attributes also'
* :another_tag, UILabel, text: 'an array' <- this is an "or", use .and for and

The more common use is to select any view or views you have assigned to variables, then perform actions on them. For example:

```ruby
view_1 = UIView.alloc.initWithFrame([[10,10],[100, 10]])
view_2 = UIView.alloc.initWithFrame([[10,20],[100, 10]])
@view_3 = append(UIView, :some_style).get

find(view_1).layout(l: 20, t: 40, w: 80, h: 20)

find(view_1, view_2, @view_3).hide
a = [view_1, view_2, @view_3]

find(a).distribute(:vertical, margin: 10)

find(a).on(:tap) do |sender|
   puts 'Tapped'
end
```
