# Tagging views

```ruby
# Add tags
find(my_view).tag(:your_tag)
find(my_view).clear_tags.tag(:your_new_tag)

find(my_view).find(UILabel).tag(:selected, :customer)

# You can use a tag or tags as selectors
find(:selected).hide
find(:your_tag).and(:selected).hide

# Check a selection for tags
find(your_view).has_tag?(:foo)

# Untag  (Available in edge and in 1.2.0 when it's released)
find(your_view).untag(:foo)
find(:your_tag).untag(:your_tag)
find(view_a, view_b).untag(:foo, bar)

# You can optionally store a value in the tag, which can be super useful in some rare situations
find(my_view).tag(your_tag: 22)
find(my_view).tag(your_tag: 22, your_other_tag: 'Hello world')

# Or, dig deep into rmq_data to see tags on a single view
your_view.rmq_data.tag_names
your_view.rmq_data.tags

```
