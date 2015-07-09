## On / Off

To add an event, use .on, to remove it it, use .off

```ruby
# Simple example
append(UIView).on(:tap){|sender| find(sender).hide}

# Adding an Event during creation
view_q = find.append(UIView).on(:tap) do |sender, event|
# do something here
end

# removing an Event
view_q.off(:tap)

# or you remove them all
view_q.off

# like everything in RMQ, this works on all items selected
find(UIView).off(:tap)
```

## RubyMotionQuery::Event

In RMQ events and gestures are normalized with the same API. For example removing events or gestures is foo.off, and the appropriate thing happens.

If you see Event, just remember that's either an event or gesture. I decided to call them Events

## Type of events and gestures

```ruby
# Events on controls
:touch
:touch_up
:touch_down
:touch_start
:touch_stop
:change

:touch_down_repeat
:touch_drag_inside
:touch_drag_outside
:touch_drag_enter
:touch_drag_exit
:touch_up_inside
:touch_up_outside
:touch_cancel

:value_changed

:editing_did_begin
:editing_changed
:editing_did_change
:editing_did_end
:editing_did_endonexit

:all_touch
:all_editing

:application
:system
:all

# Gestures
:tap
:pinch
:rotate
:swipe
:swipe_up
:swipe_down
:swipe_left
:swipe_right
:pan
:long_press
```

## Interesting methods of an RubyMotionQuery::Event:
```ruby
foo.sender
foo.event

foo.gesture?
foo.recognizer
foo.gesture

foo.location
foo.location_in

foo.sdk_event_or_recognizer
```

TODO, need many examples here

&nbsp;

## Events and user interaction

`.userInteractionEnabled` will be set to true when you add `.on` events (As of edge 0.7.1).  If you are using an older version of RMQ, you can use `.enable_interaction` in a chain like so.

```ruby

# this code allows you to place a tap event on an image
append(UIImageView, :my_picture).enable_interaction.on(:tap) do |sender|
	puts "Imageview tapped"
end

```

## Custom events

To add a custom event, use `.on` with a custom symbol. Call `.trigger` to trigger your block.

```ruby

# this code allows you to add a custom event and trigger it
append(UIView, :my_view).on(:custom_event) do |sender|
    puts "custom_event has been triggered"
end
find(:my_view).trigger(:custom_event)
```

## RubyMotionQuery::Events

The internal store of events in a UIView. It's rmq.events, you won't use it too often
