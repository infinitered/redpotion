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
