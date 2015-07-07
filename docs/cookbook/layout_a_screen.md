This example applies layouts in the stylesheet (thus why it's st.frame =), but you could also apply them using the .layout method.

<img src="http://ir_wp.s3.amazonaws.com/wp-content/uploads/sites/19/2014/05/rect_example.png" alt="rect_example" width="770" height="978" class="alignnone size-full wp-image-151" />

Notice the use of :left and :from_right together, instead of :width. This is very handy. For example if you want to place your view inside its superview (parent) and give a 5 pixel border, you would do this:

```ruby
st.frame = {l: 5, t: 5, fr: 5, fb: 5}
```

8, 9, and 10 are interesting. I placed 8 on the bottom, then put 9 above_prev: 5, and then 10 above_prev: 5. You could do this differently, but that's pretty slick.


<img src="http://ir_wp.s3.amazonaws.com/wp-content/uploads/sites/19/2014/05/layout.png" alt="layout" width="770" height="642" class="alignnone size-full wp-image-167" />

## Techniques for dealing with multiple size devices

### Develop the app using the smallest device first

You should build the app and do the layout on the smallest size device, which is usually an iPhone 4s or iPhone 5.

When I design, I take the smaller sizes, then find views that I want to expand on larger devices. For example if you're designing a **compose email** screen, the part that you could expand would be the body of the email. Making everything just larger is poor design. The user has a bigger device to see more data and UI, not make it bigger (although there is a zoom mode, but that just makes the device have the same resolution as a smaller device. So this has no effect on how you'd do layout)

If designed correctly, then the larger sizes will mostly work automatically (assuming you're using the relative layout features (such as :from_right and :below_prev).

Lastly you can do small tweaks for certain size devices.

Some designers will design every size exactly. In this case I'd still do the smallest first.

###

In your stylesheets you can use the following to make tweaks for different devices:

* `ipad?`
* `iPhone?`
* `device.width` screen width, orientation doesn't matter
* `device.height` screen height, orientation doesn't matter
* `three_point_five_inch?`
* `four_inch?`
* `four_point_seven_inch?`
* `five_point_five_inch?`
* `landscape?`
* `portrait?`

Here is an example in a stylesheet:

```
st.frame = {t: 10, bp: 10, fr: 10, h: four_inch? 150 : 180}
```

Or you can have completely different hashes per size and/or orientation:

```
st.frame = if four_inch?
  {left: 10, below_prev: 10, from_right: 10, height: 150}
elsif four_point_seven_inch?
  {left: 15, below_prev: 15, from_right: 15, height: 150}
else
  {left: 18, below_prev: 18, from_right: 18, height: 150}
end
```

If you're not in your stylesheet, then you can get to these in `device`, for example: `device.iPad?`.



## Update a view(s) frame or bounds

You can update the rectangle of a view in various ways, each way can take any of the types below (hash, array, CGRect, etc):

```ruby
# In style
st.frame = {l: 10, t: 80, w: 50, h: 20}

# One or more views using .layout
find(view_1, view_2).layout(l: 10, t: 80, w: 50, h: 20)
append(UIButton, :button_style).layout(l: 10, t: 80, w: 50, h: 20)

# One or more views using .frame
find(view_1).frame = {l: 10, t: 80, w: 50, h: 20}

# Using move or resize
find(view_1).move(l: 10, t: 80)
find(view_1).resize(w: 10, h: 80)

# Animate it
find(my_view_1).animate{|q| q.move(l: 80)}
```

You can update a frame or bounds with the following:

* hash (**preferred**)
* another RubyMotionQuery::Rect
* array
* array of array
* CGPoint
* CGSize
* CGRect

---

#### Hash

The params are always applied in this order, regardless of the hash order:

1. grid
1. l, t, w, h
1. previous
1. from_right, from_bottom
1. right, bottom
1. left and from_right applied together (will change width)
1. top and from_bottom applied together (will change height)

##### Options for layout, move, size, frame, & bounds:

* :full
* :left :l 
* :right :r
* :from_right :fr
* :top :t 
* :bottom :b
* :from_bottom :fb
* :width :w
* :height :h
* :right_of_prev :rop
* :left_of_prev :lop
* :below_prev :bp 
* :above_prev :ap
* :centered   (:vertical, :horizontal, :both)

#### Options for nudge:

* :left :l
* :right :r
* :up :u
* :down :d

#### Values for each option can be:

* signed integer
* integer
* float
* string

#### Strings are for the grid:

* 'a1:b4' 
* 'a1' 
* 'a'
* '1'
* ':b4'          

#### Previous

You can use `:below_prev: 10`, `right_of_prev: 20`, etc. **Prev** refers to the **previous sibling of this view**.

#### Some examples

```ruby
st.frame = {l: 10, t: 20, w: 100, h: 150}
st.frame = {t: 20, h: 150, l: 10, w: 100}
find(my_view).layout(l: 10, t: 20)
find(my_view).move(h: 20)
find(my_view).layout(l: :prev, t: 20, w: 100, h: 150)
find(my_view).frame = {l: 10, below_prev: 10, w: prev, h: 150}
find(my_view).frame = {left: 10, top: 20, width: 100, height: 150}
find(my_view).frame = {l: 10, t: 10, fr: 10, fb: 10}
find(my_view).frame = {width: 50, height: 20, centered: :both}
find(my_view, my_other_view).frame = {grid: "b2", w: 100, h: 200}
```

```ruby
# In a style
def some_style(st)
  st.frame = {l: 20, t: 20, w: 100, h: 50}
end

# Layout, move, or resize selected views
find(your_view).layout(left: 20, top: 20, width: 100, height: 50)
find(your_view).layout(l: 20)
find(your_view).layout(left: 20)
find(your_view).layout(l: 20, t: 20, r: 20, b: 20)
find(your_view).layout(left: 20, top: 20, width: 100, height: 50)

find(your_view).move(left: 20) # alias for layout
find(your_view).move(l: 30, t: 50) # alias for layout
find(your_view).resize(width: 100, height: 50) # alias for layout

# Nudge pushes them in a direction
find(your_view).nudge(d: 20)
find(your_view).nudge(down: 20)
find(your_view).nudge(l: 20, r: 20, u: 100, d: 50)
find(your_view).nudge(left: 20, right: 20, up: 100, down: 50)

# Other
find(your_view).resize_to_fit_subviews
find(your_view).resize_content_to_fit_subviews
```

### Getting the Rect for a view or views

```ruby
rect = find(view).frame
rect.log
puts rect
puts rect.left

# Use it directly
find(my_view).move(l: find(my_other_view).frame.l)

# If you select more than one view, you'l get an array of Rect objects
a = find(UIView).frame
```

# Distributing views

```ruby
find(UIButton).distribute
find(UIButton).distribute(:vertical)
find(UIButton).distribute(:horizontal)
find(UIButton).distribute(:vertical, margin: 20)
find(my_view, my_other_view, third_view).distribute(:vertical, margin: 10)
find(UIButton).distribute(:vertical, margins: [5,5,10,5,10,5,10,20])
```
