# Finding your way around. Traversing the app, screens, and views

Moving around the subview tree.

#### Screen, controller, and root_view

```ruby
find.screen  # alias to find.view_controller
find.view_controller
find.root_view # View of the view_controller
```

#### Window of the root_view

```ruby
find.window
```

#### All subviews, subviews of subviews, etc for root_view:

```ruby
find.all
```

#### Find

Find all children/grandchildren/etc:

```ruby
find(my_view).find  # Different from children as it keeps on going down the tree
```

More commonly, you are searching for something:

```ruby
find(my_view).find(UITextField)
```

#### Closest

Closest is interesting, and very useful. It searches through parents/grandparents/etc and finds the **first** occurrence that matches the selectors:

```ruby
find(my_view).closest(Section)
```

Let's say that someone clicked on a button in a table cell. You want to find and disable all buttons in that cell. So first you need to find the cell itself, and then find all buttons for that cell, then let's say we want to hide them. You'd do that like so:

```ruby
find(sender).closest(UITableViewCell).find(UIButton).hide
```

#### Children of selected view, views, or root_view

```ruby
find.children  # All children (but not grandchildren) of root_view
find(:section).children  # All children of any view with the tag or stylename of :section
```

##### You can also add selectors

```ruby
find(:section).children(UILabel)  # All children (that are of type UILabel of any view with the tag or stylename of :section
```

#### Parent or parents of selected view(s)

```ruby
find(my_view).parent # superview of my_view
find(my_view).parents # superview of my_view, plus any grandparents, great-grandparents, etc
find(UIButton).parent # all parents of all buttons
```

#### Siblings 

Find all your siblings:

```ruby
find(my_view).siblings # All children of my_view's parent, minus my_view)
```

Get the sibling right next to the view, below the view:

```ruby
find(my_view).next
```

Get the sibling right next to the view, above the view:

```ruby
find(my_view).prev
```

#### And, not, back, and self

These four could be thought of as Selectors, not Traversing. They kind of go in both, anywho.

By default selectors are an OR, not an AND. This will return any UILabels and anything with text == '':

```ruby
find(UILabel, text: "") # This is an OR
```

So if you want to do an **and**, do this:

```ruby
find(UILabel).and(text: "")
```

Not works the same way:

```ruby
find(UILabel).not(text: "")
```

Back is interesting, it moves you back up the chain one. In this example, we find all images that are inside test_view. Then we tag them as :foo. Now we want to find all labels in test_view and tag them :bar. So after the first tag, we go **back** up the chain to test_view, find labels, then tag them :bar:

```ruby
find(test_view).find(UIImageView).tag(:foo).back.find(UILabel).tag(:bar)
```

#### Filter

Filter is what everything else uses (parents, children, find, etc), you typically don't use it yourself.
