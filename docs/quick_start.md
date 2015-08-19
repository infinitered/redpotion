# Quick start

```
gem install redpotion

potion new my_app
cd myapp
rake
```

## Installation

- `gem install redpotion`

If you use rbenv

- `rbenv rehash`

add it to your `Gemfile`:

- `gem 'redpotion'`


## Let's build something

Let's start by creating our app, do this:

```
> potion new myapp
> cd myapp
> rake
```

Your app should be running now. Type `exit` in console to stop your app.

Let's add a text field, a button, and an image to the main screen:

Open the `home_screen.rb` file, then add this

```ruby
@image_url = append!(UITextField, :image_url)

append UIButton, :go_button

@sample_image = append!(UIImageView, :sample_image)
```

Delete this line:

```ruby
@hello_world = append!(UILabel, :hello_world)
```

Now we need to style them so you can see them on your screen.

Open up `home_screen_stylesheet.rb`, then add this:

```ruby
def image_url(st)
  st.frame = {left: 20, from_right: 20, top: 80, height: 30}
  st.background_color = color.light_gray
end

def go_button(st)
  st.frame = {below_prev: 10, from_right: 20, width: 40, height: 30}
  st.text = "go"
  st.background_color = color.blue
  st.color = color.white
end

def sample_image(st)
  st.frame = {left: 20, below_prev: 10, from_right: 20, from_bottom: 20}
  st.background_color = color.gray

  # an example of using the view directly
  st.view.contentMode = UIViewContentModeScaleAspectFit
end
```

Now let's add the logic. When the user enters a URL to an image in the text field, then tap **Go**, it shows the picture in the image view below.

Let's add the event to the go_button:

Replace this:
```ruby
append UIButton, :go_button
```

With this:
```ruby
append(UIButton, :go_button).on(:touch) do |sender|
  @sample_image.remote_image = @image_url.text
  @image_url.resignFirstResponder # Closes keyboard
end
```

You should end up with this `on_load` method:

```ruby
def on_load
  set_nav_bar_button :left, system_item: :camera, action: :nav_left_button
  set_nav_bar_button :right, title: "Right", action: :nav_right_button

  @image_url = append!(UITextField, :image_url)

  append(UIButton, :go_button).on(:touch) do |sender|
    @sample_image.remote_image = @image_url.text
    @image_url.resignFirstResponder # Closes keyboard
  end

  @sample_image = append!(UIImageView, :sample_image)
end
```

Now paste this URL in and hit **Go**
`http://bit.ly/18iMhwc`

You should have this:

![image](http://ir_wp.s3.amazonaws.com/wp-content/uploads/sites/11/2015/03/myapp_screenshot.jpg)
