Adding rmq_debug=true to rake turns on some debugging features that are too slow or verbose to include in a normal build.  It's great for normal use in the simulator, but you'll want to leave it off if you're measuring performance.
```
rake rmq_debug=true
```

Use this to add your optional debugging code
```ruby
RubyMotionQuery::RMQ.debugging?
=> true
```

You can even change the value from the REPL (useful for turning on and off features)
```ruby
RubyMotionQuery::RMQ.debugging = true
=> true
```

`rmq.debug.colorize` - Often times, you may want high contrast on a selection of items, so you can lay them out or identify them on the screen.  One common practice we use is to assign all the selected with a random background color.   Since this is so common, we've created a shortcut method to help.
```ruby
find(<selected items here, usually UIView or some class>).debug.colorize
```

Other Debugging Items
```ruby
rmq.log :tree
find.all.log
find.all.log :wide

find(Section).log :tree
# 163792144 is the ID a button
find(163792144).style{|st| st.background_color = rmq.color.blue}

find(Section).children.and_self.log :wide

find(UILabel).animations.blink

# Show subview index and thus zorder of Section within Section's parent
find(Section).parent.children.log
```
