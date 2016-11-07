## General images

RedPotion provides various features for dealing with images.

If you want to load an image from your **/resources** folder (_which is where they should be_), you can either load it and cache it (**imageNamed**) or load it and not cache it (**NSBundle.mainBundle.pathForResource**). ProMotion takes care of the details:

```ruby
image.resource('foo') # /resources/foo@2x.png
image.resource('foo', cached: false)
# In a stylesheet
st.background_image = image.resource('foo')
```

**Snapshot of a view**

Lastly you can get an image of a view, meaning a "screenshot" of it:

```ruby
my_image_view.image = image.from_view(some_view)
```

**Other examples**

```ruby
RubyMotionQuery::ImageUtils.resource('logo')
image.resource('logo')
image.resource('subfolder/foo')
image.resource_for_device('logo') # will look for 4inch or 3.5inch
image.resource('logo', cached: false)

image.resource_resizable('foo', left: 10, top: 10, right: 10, bottom: 10)

image.from_view(my_view)
```

------

## Remote images

You can set `remote_image` to a URL string or an instance of `NSURL` and it will automatically fetch the image and set the image (with caching) using the power of [SDWebImage](https://github.com/rs/SDWebImage).

```ruby
class MyStylesheet < ApplicationStylesheet
  def my_ui_image_view(st)
    # placeholder_image= is just an alias to image=
    # Set the placeholder image you want from your resources directory
    st.placeholder_image = image.resource("my_placeholder")
    # Set the remote URL. It will be applied to the UIImageView
    # when downloaded or retrieved from the local cache.
    st.remote_image = "http://www.rubymotion.com/img/rubymotion-logo.png"
    # or st.remote_image = NSURL.urlWithString(...)
  end
end
```

You can also call `remote_image` with a closure to execute once the remote image has finished loading. It takes a hash with `url` and `did_load` keys.

```ruby
your_ui_image_view.remote_image({ url: 'http://bit.ly/18iMhwc',
                                  did_load: -> { puts 'Image finished loading!' } })

# Or

your_ui_image_view.remote_image({ url: NSURL.urlWithString(...),
                                  did_load: -> { puts 'Image finished loading!' } })
```

To assign a remote image to a UIImageView:

```ruby
your_ui_image_view.remote_image = "http://bit.ly/18iMhwc"
```

We also provide an easy way to reset all images cached by SDWebImage. If you're using ProMotion screens, you should probably do this in your `on_memory_warning` method on each screen. If using standard `UIViewController` subclasses, add this to your `didReceiveMemoryWarning` method.

```ruby
app.reset_image_cache!
```

------

## Capped Images

Sometimes when you apply a background_image to a view you want the image to stretch to the size of the view without stretching the corners of the image, for example if you're making a rounded button. The SDK has a nice feature for this, called UIImage#resizableImageWithCapInsets. It stretches the center of your image, but not the corners.

Let's say you want to create this, like we did in [Temple](http://app.temple.cx/):

![Bar](https://ir_wp.s3.amazonaws.com/wp-content/uploads/sites/18/2014/03/bar.png)

The red bar grows horizontally. But it has rounded caps. So we created this image ![Cap image](https://ir_wp.s3.amazonaws.com/wp-content/uploads/sites/18/2014/03/bar_poor@2x.png), which is the caps, plus one pixel to stretch. Here it is blown up and I dimmed the 4 caps:

![Cap image](https://ir_wp.s3.amazonaws.com/wp-content/uploads/sites/18/2014/03/blown_up.png)

Basically just the center line of it stretches, the other 4 quadrants do not. ProMotion makes this very easy. You create a UIImageView, then in the style (or anywhere) you set the image like so:

```ruby
append(UIImageView, :your_style)

# Then in your style
st.image = image.resource_resizable('your_image', top: 4, left: 4, right: 4, bottom: 4)
```

The top, left, etc, tell which p
