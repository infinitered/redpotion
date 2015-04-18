## Live stylesheet reloading

In REPL, type: `live_stylesheets`

![image](http://clrsight.co/jh/LiveReload4.gif?+)


## Generators

Like Rails, RedPotion provides a command-line tool, mostly for generating files. 

**Create a new app**:

```
> potion create my_app
```

To get all the commands available just do:

```
> potion

potion version 1.1.1

Some things you can do with the potion command:

> potion create my_new_app
> potion create my_new_app --skip-cdq # Setup application without CDQ

> potion create model foo
> potion create screen foo
> potion create table_screen foo
> potion create metal_table_screen foo
> potion create view bar
> potion create shared some_class_used_app_wide
> potion create lib some_class_used_by_multiple_apps

You can still create controllers, but you should create screens instead
> potion create controller foos
> potion create collection_view_controller foos
> potion create table_view_controller bars

You can remove CDQ or afmotion if your project does not use it
> potion remove cdq
> potion remove afmotion

Misc
> potion -h, --help
> potion -v, --version

Documentation
> rmq docs
> rmq docs query
> rmq docs "background image"```
```

I recomend you play around with it, do this:

```
> cd
> cd Desktop
> potion create test_app
> cd test_app
> bundle
> rake pod:install
> rake spec
> rake
> potion create screen test
> potion create table_screen test_table
> potion create view test_view
```

## Console Fun

----

```ruby
rmq.log :tree
find.all.log
find.all.log :wide
find(UIView).frame.log
find(UIView).show
find(UILabel).animations.blink
find(UIButton).nudge l: 10
```
