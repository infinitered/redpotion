### What is a Styler?
A styler wraps around a view, augmenting it with styling power and sugar.

Each UIView subclass can have its own styler (many exist in RMQ, but not all *yet*). There is a UIViewStyler class they all inherit from, and a UIControlStyler controls inherit from. Much of the code is in UIViewStyler.

When you create a "style method", it will be passed the view, wrapped in a styler. You can get the view using st.view.

You can see a list of styler methods using: `rmq.log_stylers`

-----

## List of stylers, their methods, and some examples

### UIViewStyler

All stylers inherit UIViewStyler, so these are available in any view.

* absolute_frame=(value)
* accessibility_label=(value)
* alpha
* alpha=(value)
* background_color
* background_color=(value)
* background_gradient=(value)
* background_image=(value)
* border=(value)
* border_color
* border_color=(value)
* border_width
* border_width=(value)
* bounds
* bounds=(value)
* center
* center=(value)
* center_x
* center_x=(value)
* center_y
* center_y=(value)
* centered=(value)
* clips_to_bounds
* clips_to_bounds=(value)
* content_mode
* content_mode=(value)
* copyWithZone
* corner_radius
* corner_radius=(value)
* corner_radius=(value)
* enabled
* enabled=(value)
* frame
* frame=(value)
* get
* hidden
* hidden=(value)
* layer
* masks_to_bounds
* masks_to_bounds=(value)
* opacity
* opacity=(value)
* opaque
* opaque=(value)
* parent
* prev_frame
* prev_view
* right
* right=(value)
* rotation=(value)
* scale=(value)
* shadow_color
* shadow_color=(value)
* shadow_offset
* shadow_offset=(value)
* shadow_opacity
* shadow_opacity=(value)
* shadow_path
* shadow_path=(value)
* super_height
* super_width
* superview
* tag
* tint_color
* tint_color=(value)
* transform
* transform=(value)
* user_interaction_enabled
* user_interaction_enabled=(value)
* validation_errors=(value)
* view
* view=(value)
* view_has_been_styled?
* z_position
* z_position=(value)

```ruby
st.frame = {l: 1, t: 2, w: 3, h: 4}
st.frame = {left: 1, top: 2, width: 3, height: 4}
st.frame = {from_right: 1, from_bottom: 2, width: 3, height: 4}
st.frame = {fr: 1, fb: 2, w: 3, h: 4}
st.center = st.superview.center
st.center_x = 50
st.center_y = 60

st.enabled = true
st.hidden = false
st.z_position = 66
st.opaque = false
st.clips_to_bounds = false
st.hidden = true
st.content_mode = UIViewContentModeBottomLeft

st.background_color = color.red

st.scale = 1.5
st.rotation = 45
st.tint_color = color.blue
st.layer.cornerRadius = 5
```


### UIControlStyler

All UIControl stylers, like a UIButton, inherit from UIControlStyler

* content_horizontal_alignment
* content_horizontal_alignment=(value)
* content_vertical_alignment
* content_vertical_alignment=(value)
* highlighted
* highlighted=(value)
* selected
* selected=(value)
* state

```ruby
st.content_vertical_alignment = UIControlContentVerticalAlignmentFill
st.content_horizontal_alignment = UIControlContentHorizontalAlignmentFill
st.selected = true
st.highlighted = true
```


### UIActivityIndicatorViewStyler

* activity_indicator_style
* activity_indicator_style=(value)
* animating?
* color
* color=(value)
* hides_when_stopped
* hides_when_stopped=(value)
* is_animating?
* start
* start_animating
* stop
* stop_animating


### UIButtonStyler

* adjust_image_when_highlighted
* adjust_image_when_highlighted=(value)
* attributed_text
* attributed_text=(value)
* attributed_text_highlighted
* attributed_text_highlighted=(value)
* background_image
* background_image_highlighted
* background_image_highlighted=(value)
* background_image_normal
* background_image_normal=(value)
* background_image_selected
* background_image_selected=(value)
* color
* color=(value)
* color_highlighted
* color_highlighted=(value)
* content_horizontal_alignment
* content_horizontal_alignment=(value)
* content_vertical_alignment
* content_vertical_alignment=(value)
* font
* font=(value)
* highlighted
* highlighted=(value)
* image
* image=(value)
* image_edge_insets
* image_edge_insets=(value)
* image_highlighted
* image_highlighted=(value)
* image_normal
* image_normal=(value)
* selected
* selected=(value)
* state
* text
* text=(value)
* text_highlighted
* text_highlighted=(value)
* title_edge_insets
* title_edge_insets=(value)

```ruby
st.text = 'foo'
st.font = font.system(12)
st.color = color.red
st.image_normal = image.resource('logo')
st.image_highlighted = image.resource('logo')
```


### UIDatePickerStyler

* content_horizontal_alignment
* content_horizontal_alignment=(value)
* content_vertical_alignment
* content_vertical_alignment=(value)
* date_picker_mode
* date_picker_mode=(value)
* highlighted
* highlighted=(value)
* selected
* selected=(value)
* state


### UIImageViewStyler

* image
* image=(value)

```ruby
st.image = image.resource('logo')
```


### UILabelStyler

* adjusts_font_size
* adjusts_font_size=(value)
* adjusts_font_size_to_fit_width
* adjusts_font_size_to_fit_width=(value)
* attributed_text
* attributed_text=(value)
* color
* color=(value)
* font
* font=(value)
* line_break_mode
* line_break_mode=(value)
* number_of_lines
* number_of_lines=(value)
* resize_height_to_fit
* resize_to_fit_text
* size_to_fit
* text
* text=(value)
* text_align
* text_align=(value)
* text_alignment
* text_alignment=(value)
* text_color
* text_color=(value)

```ruby
st.text = 'rmq is awesome'
st.font = font.system(12)
st.color = color.black
st.text_alignment = :center

st.resize_to_fit_text
st.size_to_fit
```

### UINavigationBarStyler


### UIPageControlStyler

* content_horizontal_alignment
* content_horizontal_alignment=(value)
* content_vertical_alignment
* content_vertical_alignment=(value)
* current_page
* current_page=(value)
* current_page_indicator_tint_color
* current_page_indicator_tint_color=(value)
* highlighted
* highlighted=(value)
* number_of_pages
* number_of_pages=(value)
* page_indicator_tint_color
* page_indicator_tint_color=(value)
* selected
* selected=(value)
* state


### UIProgressViewStyler

* progress_image
* progress_image=(value)
* progress_tint_color
* progress_tint_color=(value)
* progress_view_style
* progress_view_style=(value)
* track_image
* track_image=(value)
* track_tint_color
* track_tint_color=(value)


### UIRefreshControlStyler

* content_horizontal_alignment
* content_horizontal_alignment=(value)
* content_vertical_alignment
* content_vertical_alignment=(value)
* highlighted
* highlighted=(value)
* selected
* selected=(value)
* state


### UIScrollViewStyler

* bounces
* bounces=(value)
* content_inset
* content_inset=(value)
* content_offset
* content_offset=(value)
* content_size
* content_size=(value)
* direction_lock
* direction_lock=(value)
* indicator_style
* indicator_style=(value)
* paging
* paging=(value)
* scroll_enabled
* scroll_enabled=(value)
* scroll_indicator_insets
* scroll_indicator_insets=(value)
* shows_horizontal_scroll_indicator
* shows_horizontal_scroll_indicator=(value)
* shows_vertical_scroll_indicator
* shows_vertical_scroll_indicator=(value)

```ruby
st.paging = true
st.scroll_enabled = true
st.direction_lock = false
st.content_offset = CGPointMake(5, 10)
st.content_inset = CGPointMake(-100, 0)
st.bounces = false
st.content_size = CGSizeMake(320, 500)
st.shows_horizontal_scroll_indicator = true
st.shows_vertical_scroll_indicator = false
st.scroll_indicator_insets = UIEdgeInsetsMake (10, 0, 20, 0)
```

### UISegmentedControlStyler

* content_horizontal_alignment
* content_horizontal_alignment=(value)
* content_vertical_alignment
* content_vertical_alignment=(value)
* highlighted
* highlighted=(value)
* prepend_segments=(value)
* selected
* selected=(value)
* state
* unshift=(value)


### UISliderStyler

* content_horizontal_alignment
* content_horizontal_alignment=(value)
* content_vertical_alignment
* content_vertical_alignment=(value)
* highlighted
* highlighted=(value)
* selected
* selected=(value)
* state


### UIStepperStyler

* content_horizontal_alignment
* content_horizontal_alignment=(value)
* content_vertical_alignment
* content_vertical_alignment=(value)
* highlighted
* highlighted=(value)
* selected
* selected=(value)
* state


### UISwitchStyler

* content_horizontal_alignment
* content_horizontal_alignment=(value)
* content_vertical_alignment
* content_vertical_alignment=(value)
* highlighted
* highlighted=(value)
* on
* on=(value)
* selected
* selected=(value)
* state

```ruby
st.on = true
```

### UITabBarStyler


## UITableViewCellStyler

* accessory_type
* accessory_type=(value)
* accessory_view
* accessory_view=(value)
* color
* color=(value)
* detail_color
* detail_color=(value)
* detail_font
* detail_font=(value)
* detail_text_color
* detail_text_color=(value)
* font
* font=(value)
* selection_style
* selection_style=(value)
* separator_inset
* separator_inset=(value)
* text_color
* text_color=(value)


### UITableViewStyler

* allows_selection
* allows_selection=(value)
* background_image
* bounces
* bounces=(value)
* content_inset
* content_inset=(value)
* content_offset
* content_offset=(value)
* content_size
* content_size=(value)
* direction_lock
* direction_lock=(value)
* indicator_style
* indicator_style=(value)
* paging
* paging=(value)
* row_height=(value)
* scroll_enabled
* scroll_enabled=(value)
* scroll_indicator_insets
* scroll_indicator_insets=(value)
* separator_color
* separator_color=(value)
* separator_inset=(value)
* separator_style
* separator_style=(value)
* shows_horizontal_scroll_indicator
* shows_horizontal_scroll_indicator=(value)
* shows_vertical_scroll_indicator
* shows_vertical_scroll_indicator=(value)


### UITextFieldStyler

* adjusts_font_size
* adjusts_font_size=(value)
* adjusts_font_size_to_fit_width
* adjusts_font_size_to_fit_width=(value)
* allows_editing_text_attributes
* allows_editing_text_attributes=(value)
* attributed_placeholder
* attributed_placeholder=(value)
* attributed_text
* attributed_text=(value)
* autocapitalization_type
* autocapitalization_type=(value)
* autocorrection_type
* autocorrection_type=(value)
* background
* background=(value)
* border_style
* border_style=(value)
* clear_button_mode
* clear_button_mode=(value)
* clears_on_begin_editing
* clears_on_begin_editing=(value)
* clears_on_insertion
* clears_on_insertion=(value)
* color
* color=(value)
* content_horizontal_alignment
* content_horizontal_alignment=(value)
* content_vertical_alignment
* content_vertical_alignment=(value)
* default_text_attributes
* default_text_attributes=(value)
* disabled_background
* disabled_background=(value)
* editing
* editing=(value)
* enables_return_key_automatically
* enables_return_key_automatically=(value)
* font
* font=(value)
* highlighted
* highlighted=(value)
* keyboard_appearance
* keyboard_appearance=(value)
* keyboard_type
* keyboard_type=(value)
* left_view
* left_view=(value)
* left_view_mode
* left_view_mode=(value)
* minimum_font_size
* minimum_font_size=(value)
* placeholder
* placeholder=(value)
* return_key_type
* return_key_type=(value)
* right_view
* right_view=(value)
* right_view_mode
* right_view_mode=(value)
* secure_text_entry
* secure_text_entry=(value)
* selected
* selected=(value)
* spell_checking_type
* spell_checking_type=(value)
* state
* text
* text=(value)
* text_alignment
* text_alignment=(value)
* text_color
* text_color=(value)
* typing_attributes
* typing_attributes=(value)


### UITextViewStyler

* attributed_text
* attributed_text=(value)
* bounces
* bounces=(value)
* color
* color=(value)
* content_inset
* content_inset=(value)
* content_offset
* content_offset=(value)
* content_size
* content_size=(value)
* data_detector_types
* data_detector_types=(value)
* direction_lock
* direction_lock=(value)
* editable
* editable=(value)
* font
* font=(value)
* indicator_style
* indicator_style=(value)
* paging
* paging=(value)
* scroll_enabled
* scroll_enabled=(value)
* scroll_indicator_insets
* scroll_indicator_insets=(value)
* selectable
* selectable=(value)
* shows_horizontal_scroll_indicator
* shows_horizontal_scroll_indicator=(value)
* shows_vertical_scroll_indicator
* shows_vertical_scroll_indicator=(value)
* text
* text=(value)
* text_alignment
* text_alignment=(value)
* text_color
* text_color=(value)

```ruby
st.frame = {l: 1, t: 2, w: 3, h: 4}
st.frame = {left: 1, top: 2, width: 3, height: 4}
st.frame = {from_right: 1, from_bottom: 2, width: 3, height: 4}
st.frame = {fr: 1, fb: 2, w: 3, h: 4}
st.center = st.superview.center
st.center_x = 50
st.center_y = 60

st.enabled = true
st.hidden = false
st.z_position = 66
st.opaque = false
st.clips_to_bounds = false
st.hidden = true
st.content_mode = UIViewContentModeBottomLeft

st.background_color = color.red

st.scale = 1.5
st.rotation = 45
st.tint_color = color.blue
st.layer.cornerRadius = 5
```

### UIControlStyler

```ruby
st.content_vertical_alignment = UIControlContentVerticalAlignmentFill
st.content_horizontal_alignment = UIControlContentHorizontalAlignmentFill
st.selected = true
st.highlighted = true
```

### UILabelStyler

```ruby
st.text = 'rmq is awesome'
st.font = font.system(12)
st.color = color.black
st.text_alignment = :center

st.resize_to_fit_text
st.size_to_fit
```

### UIButtonStyler

```ruby
st.text = 'foo'
st.font = font.system(12)
st.color = color.red
st.image_normal = image.resource('logo')
st.image_highlighted = image.resource('logo')
```

### UIImageViewStyler

```ruby
st.image = image.resource('logo')
```

### UIScrollViewStyler

```ruby
st.paging = true
st.scroll_enabled = true
st.direction_lock = false
st.content_offset = CGPointMake(5, 10)
st.content_inset = CGPointMake(-100, 0)
st.bounces = false
st.content_size = CGSizeMake(320, 500)
st.shows_horizontal_scroll_indicator = true
st.shows_vertical_scroll_indicator = false
st.scroll_indicator_insets = UIEdgeInsetsMake (10, 0, 20, 0)
```

### UISwitchStyler

* on=(value)

```ruby
st.on = true
```

-----

## Adding your own styler

In the example app, look in **/app/stylers**, you can just copy that whole folder to start. Then add methods to the appropriate class.

Here is an example of adding a method to all stylers:

```ruby
module RubyMotionQuery
  module Stylers
    class UIViewStyler

      def border_width=(value)
        @view.layer.borderWidth = value
      end
      def border_width
        @view.layer.borderWidth
      end

    end
  end
end
```

You can also include all of your custom stylers in one file, which works well if you don't have a lot.
