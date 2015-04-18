## Animating

The most basic:

```ruby
find.animate do
  find(UIButton).nudge r: 40
end
```

A better way to do that is select something first. In this case `q` is an RMQ instance selecting all UIButtons:

```ruby
find(UIButton).animate do |q|
  q.nudge r: 40
end
```
Some more options, this time it is animating a selected view:

```ruby
find(my_view).animate(
  duration: 0.3,
  animations: lambda{|q|
    q.move left: 20
  }
)
```

```ruby
# As an example, this is the implementation of .animations.throb
find(selectors).animate(
  duration: 0.1,
  animations: -> (q) {
    q.style {|st| st.scale = 1.1}
  },
  completion: -> (did_finish, q) {
    q.animate(
      duration: 0.4,
      animations: -> (cq) {
        cq.style {|st| st.scale = 1.0}
      }
    )
  }
)

# You can pass any options that animateWithDuration allows: options: YOUR_OPTIONS
```

# Built-in animations

```ruby
find(my_view).animations.fade_in
find(my_view).animations.fade_in(duration: 0.8)
find(my_view).animations.fade_out
find(my_view).animations.fade_out(duration: 0.8)

find(my_view).animations.blink
find(my_view).animations.throb
find(my_view).animations.sink_and_throb
find(my_view).animations.land_and_sink_and_throb
find(my_view).animations.drop_and_spin # has optional param 'remove_view: true'

find(my_view).animations.slide_in # default from_direction: :right
find(my_view).animations.slide_in(from_direction: :left) # acceptable directions :left, :right, :top, :bottom

find(my_view).animations.slide_out # default to_direction: :left, also accepts :right, :top, and :bottom
find(my_view).animations.slide_out(remove_view: true) # removes the view from superview after animation
find(my_view).animations.slide_out(to_direction: :top, remove_view: true) #combining options example

find.animations.start_spinner
find.animations.stop_spinner
```

<strong>Fade In</strong>

<img class="alignnone size-full wp-image-177" src="http://ir_wp.s3.amazonaws.com/wp-content/uploads/sites/19/2014/05/fade_in.gif" alt="fade_in" width="476" height="212" />

&nbsp;

<strong>Fade Out</strong>

<img class="alignnone size-full wp-image-178" src="http://ir_wp.s3.amazonaws.com/wp-content/uploads/sites/19/2014/05/fade_out.gif" alt="fade_out" width="474" height="212" />

<strong>Blink</strong>

<img class="alignnone size-full wp-image-179" src="http://ir_wp.s3.amazonaws.com/wp-content/uploads/sites/19/2014/05/blink.gif" alt="blink" width="474" height="214" />

<strong>Throb</strong>

<img class="alignnone size-full wp-image-180" src="http://ir_wp.s3.amazonaws.com/wp-content/uploads/sites/19/2014/05/throb.gif" alt="throb" width="474" height="214" />

<strong>Sink and Throb</strong>

<img class="alignnone size-full wp-image-181" src="http://ir_wp.s3.amazonaws.com/wp-content/uploads/sites/19/2014/05/sink_and_throb.gif" alt="sink_and_throb" width="472" height="212" />

<strong>Land and Sink and Throb</strong>

<img class="alignnone size-full wp-image-182" src="http://ir_wp.s3.amazonaws.com/wp-content/uploads/sites/19/2014/05/land_sink_throb.gif" alt="land_sink_throb" width="476" height="214" />

<strong>Drop and Spin</strong>

<img class="alignnone size-full wp-image-183" src="http://ir_wp.s3.amazonaws.com/wp-content/uploads/sites/19/2014/05/drop_spin.gif" alt="drop_spin" width="470" height="214" />

<strong>Slide In
<img class="alignnone size-full wp-image-207" src="http://ir_wp.s3.amazonaws.com/wp-content/uploads/sites/19/2014/05/slide_in.gif" alt="slide_in" width="472" height="210" />
</strong>

<strong>Slide Out
<a href="http://ir_wp.s3.amazonaws.com/wp-content/uploads/sites/19/2014/05/slide_out.gif"><img class="alignnone size-full wp-image-208" src="http://ir_wp.s3.amazonaws.com/wp-content/uploads/sites/19/2014/05/slide_out.gif" alt="slide_out" width="474" height="208" /></a>
</strong>
