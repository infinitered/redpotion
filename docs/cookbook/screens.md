RedPotion uses ProMotion's screens.

|Screens|Navigation Bars|Tab Bars|
|---|---|---|
|[![ProMotion Screen](https://f.cloud.github.com/assets/1479215/1534021/060aaaac-4c8f-11e3-903c-743e54252222.png)](http://promotion.readthedocs.org/en/master/API%20Reference%20-%20ProMotion%20Screen/)|[![ProMotion Nav Bar](https://f.cloud.github.com/assets/1479215/1534077/db39aab6-4c8f-11e3-83f7-e03d52ac615d.png)](http://promotion.readthedocs.org/en/master/API%20Reference%20-%20ProMotion%20Screen/#set_nav_bar_buttonside-args)|[![ProMotion Tabs](https://f.cloud.github.com/assets/1479215/1534115/9f4c4cd8-4c90-11e3-9285-96ac253facda.png)](http://promotion.readthedocs.org/en/master/API%20Reference%20-%20ProMotion%20Tabs/)|

|Table Screens|Grouped Tables|Searchable|Refreshable|
|---|---|---|---|
|[![ProMotion TableScreen](https://f.cloud.github.com/assets/1479215/1534137/ed71e864-4c90-11e3-98aa-ed96049f5407.png)](http://promotion.readthedocs.org/en/master/API%20Reference%20-%20ProMotion%20TableScreen/)|[![Grouped Table Screen](https://f.cloud.github.com/assets/1479215/1589973/61a48610-5281-11e3-85ac-abee99bf73ad.png)](https://gist.github.com/jamonholmgren/382a6cf9963c5f0b2248)|[![Searchable](https://f.cloud.github.com/assets/1479215/1534299/20cc05c6-4c93-11e3-92ca-9ee39c044457.png)](http://promotion.readthedocs.org/en/master/API%20Reference%20-%20ProMotion%20TableScreen/#searchableplaceholder-placeholder-text)|[![Refreshable](https://f.cloud.github.com/assets/1479215/1534317/5a14ef28-4c93-11e3-8e9e-f8c08d8464f8.png)](http://promotion.readthedocs.org/en/master/API%20Reference%20-%20ProMotion%20TableScreen/#refreshableoptions)|


|iPad SplitScreens|Map Screens|Web Screens|
|---|---|---|
|[![ProMotion SplitScreens](https://f.cloud.github.com/assets/1479215/1534507/0edb8dd4-4c96-11e3-9896-d4583d0ed161.png)](http://promotion.readthedocs.org/en/master/API%20Reference%20-%20ProMotion%20SplitScreen/)|[![MapScreen](https://f.cloud.github.com/assets/1479215/1534628/f7dbf7e8-4c97-11e3-8817-4c2a58824771.png)](http://promotion.readthedocs.org/en/master/API%20Reference%20-%20ProMotion%20MapScreen/)|[![ProMotion WebScreen](https://f.cloud.github.com/assets/1479215/1534631/ffe1b36a-4c97-11e3-8c8f-c7b14e26182d.png)](http://promotion.readthedocs.org/en/master/API%20Reference%20-%20ProMotion%20WebScreen/)|

#### ...and much more.

----

PM::Screen is the primary object in ProMotion and a subclass of UIViewController. It adds some abstraction to make your life easier while still allowing the full power of a UIViewController.

```ruby
class HomeScreen < PM::Screen
  title "Home"
  tab_bar_item item: "home-screen-tab", title: "Home"
  status_bar :light
  stylesheet HomeScreenStylesheet

  def on_load
    set_nav_bar_button :right, title: "Next", action: :go_to_next

    # set up subviews here
    append UIView, :some_style
  end

  # custom method, triggered by tapping right nav bar button set above
  def go_to_next
    open NextScreen # opens in same navigation controller, assuming we're in one
  end

  def will_appear
    # just before the view appears
  end

  def on_appear
    # just after the view appears
  end

  def will_disappear
    # just before the view disappears
  end

  def on_disappear
    # just after the view disappears
  end

end
```

---

### Lifecycle Methods

All lifecycle methods are optional, but provide hooks for you to do certain tasks. These usually coincide with Cocoa Touch lifecycle methods but have slightly different semantics.

In ProMotion, `will_*` methods usually fire before an action, and `on_*` methods fire just after.

#### on_init

Fires only once, after the screen has been instantiated and all provided properties set. A good place to do further initialization of instance variables or set your tab bar icon.

```ruby
def on_init
  @my_car = "Dude, where's my car?"
  set_tab_bar_item item: :favorites
end
```

#### screen_setup

Primarily used for setting up reusable PM::Screen subclasses, such as PM::WebScreen. Not recommended for normal app screens. But if you are building a subclass for a gem, this is where you would do your additional setup.

```ruby
class PM::LaserScreen < UILaserViewController
  include PM::ScreenModule

  def screen_setup
    self.laserView = set_up_view
  end
end
```

#### load_view

Used for creating your screen's root view. If you don't implement this method or if you do and you fail to create a view, ProMotion will create a blank one for you.

Only fires when the `view` property is accessed for the first time.

```ruby
def load_view
  self.view = UIView.alloc.initWithFrame(UIScreen.mainScreen.bounds)
end
```

#### on_load

Fires once, when the root view of the screen is accessed for the first time. This is where you normally add and style your subviews.

Keep in mind this method doesn't necessarily fire right away. For example, if you're creating a tab bar with four screens, the three screens that are not active will not fire `on_load` until you tap their tab. That's because the view isn't accessed until that moment.

```ruby
def on_load
end
```

#### will_appear

Runs just before the screen appears. Often used to ensure the right information is displayed.

```ruby
def will_appear
  @name.text = @user.name
end
```

#### will_present

Runs just before the screen is pushed onto the navigation controller. Usually fires immediately after `will_appear`, but only if it is the first time that the screen is added to the navigation controller.

Not used all that often, but can be useful in some cases.

```ruby
def will_present
  # About to present
end
```

#### on_appear

Runs just after the screen has appeared and stopped animating. Sometimes used to kick off other animations or start playing a video.

```ruby
def on_appear
  @video.startPlaying
end
```


#### on_present

Runs just after the screen is pushed onto the navigation controller. Usually fires just after `on_appear`, but only when the screen is first added to the navigation controller.

```ruby
def on_present
  # Presented
end
```

#### will_disappear

Runs just before the screen disappears from the screen. An example usage would be to stop a video from playing.

```ruby
def will_disappear
  @video.stopPlaying
end
```

#### will_dismiss

Runs just before the screen is removed from its parent. Usually happens when getting popped off a navigation controller stack. Fires right after `will_disappear`.

```ruby
def will_dismiss
  # dismissing
end
```

#### on_dismiss

Runs just after the screen is removed from its parent.

```ruby
def on_dismiss
  # dismissed, screen is about to be deallocated probably
end
```

#### should_autorotate

(iOS 6+) return true/false if screen should autorotate.
Defaults to true.

```ruby
def should_autorotate
  false
end
```

#### should_rotate(orientation)

(iOS 5) Return true/false for rotation to orientation. Tries to resolve this automatically from your `UISupportedInterfaceOrientations` setting. You normally do not override this method.

```ruby
def should_rotate(orientation)
  if device.portrait?
    true
  else
    false
  end
end
```

#### will_rotate(orientation, duration)

Runs just before the device is rotated.

```ruby
def will_rotate(orientation, duration)
  # about to rotate
end
```

#### on_rotate

Runs just after the device is rotated.

```ruby
def on_rotate
  # we've rotated
end
```

---

### Methods

### try(method, *args)

Sends `method(*args)` to the current screen if the current screen will `respond_to?(method)`


#### modal?

Returns if the screen was opened in a modal window.

```ruby
m = ModalScreen.new
open_modal m
m.modal? # => true
```

#### nav_bar?

Returns if the screen is currently contained in a navigation controller.

```ruby
open s = HomeScreen.new(nav_bar: true)
s.nav_bar? # => true
```

#### will_rotate(orientation, duration)

Runs just before the screen rotates.

#### set_nav_bar_button(side, args = {})

Set a nav bar button. `args` can be `image:`, `title:`, `system_item:`, `button:`, `custom_view:`.

You can also set arbitrary attributes in the hash and they'll be applied to the button.

```ruby
set_nav_bar_button :left, {
  title: "Button Title",
  image: UIImage.imageNamed("left-nav"),
  system_item: :reply,
  tint_color: UIColor.blueColor,
  button: UIBarButtonItem.initWithTitle("My button", style: UIBarButtonItemStyleBordered, target: self, action: :tapped_button) # for custom button
}
```

`system_item` can be a `UIBarButtonSystemItem` or one of the following symbols:
```ruby
:done,:cancel,:edit,:save,:add,:flexible_space,:fixed_space,:compose,
:reply,:action,:organize,:bookmarks,:search,:refresh,:stop,:camera,
:trash,:play,:pause,:rewind,:fast_forward,:undo,:redo,:page_curl
```

`custom_view` can be any custom `UIView` subclass you initialize yourself

Another example with arbitrary attributes:

```ruby
set_nav_bar_button :right, {
  system_item: :add,
  action: :add_item,
  accessibility_label: "add item",
  background_color: image.resource("some-image")
}
```

And finally, you can also set the `:back` nav bar image on a screen and it will render a back arrow icon in the upper left part of the navigation. However, note that doing so will change the back button for all descendants of the screen you set the button on. This behavior is a little unintuitive, but is a result of the underlying Cocoa Touch APIs. For example:

```ruby
class MyScreen < PM::Screen
  def on_init
    set_nav_bar_button :back, title: 'Cancel', style: :plain, action: :back
  end

  def go_to_next_screen
    open MyScreenChild
  end
end
```

The code above will add a "cancel" back button to `MyScreenChild` when it is opened as a descendant of `MyScreen`.

#### set_nav_bar_buttons(side, button_array)

Allows you to set multiple buttons on one side of the nav bar with a single method call. The second parameter should be an array of any mixture of UIBarButtonItem instances and hash constructors used in set_nav_bar_button

```ruby
set_nav_bar_buttons :right, [{
  custom_view: my_custom_view_button
},{
  title: "Tasks",
  image: image.resource("whatever"),
  action: nil
}]
```

#### set_toolbar_items(buttons = [], animated = true)

Uses an array to set the navigation controllers toolbar items and shows the toolbar. Uses the same hash formatted parameters as `set_nav_bar_button`. When calling this method, the toolbar will automatically be shown (even if the screen was created without a toolbar). Use the `animated` parameter to specify if the toolbar showing should be animated or not.

```ruby
# Will arrange one button on the left and another on the right
set_toolbar_items [{
    title: "Button Title",
    action: :some_action
  }, {
    system_item: :flexible_space
  }, {
    title: "Another ButtonTitle",
    action: :some_other_action,
    target: some_other_object
  }]
```

You can also pass your own initialized `UIBarButtonItem` as part of the array (instead of a hash object).

_EDGE FEATURE:_ You can pass `tint_color` with a `UIColor` to change the tint color of the button item.

#### title

Returns title of current screen.

```ruby
class MyScreen < PM::Screen
  title "Mine"
  def on_load
    self.title # => "Mine"
  end
```

#### title=(title)

Sets the text title of current screen instance. Note that you must declare `self` as the receiver.

```ruby
class SomeScreen
  def on_load
    # This sets this instance's title
    self.title = "Something else"
  end
end
```


#### close(args = {})

Closes the current screen, passes `args` back to the previous screen's `on_return` method (if it exists).

```ruby
class ChildScreen < PM::Screen
  def save_and_close
    save
    close({ saved: true })
  end
end

class ParentScreen < PM::Screen
  def on_return(args={})
    if args[:saved]
      reload_data
    end
  end
end
```

If you want to close back to the root screen or any other screen in the navigation stack, use `to_screen:`:

```ruby
class ChildScreen < PM::Screen
  def close_to_root
    close to_screen: self.navigation_controller.viewControllers.first
    # For the rootViewController, you can just use `:root`
    close to_screen: :root
  end
end
```

#### open_root_screen(screen)

Closes all other open screens and opens `screen` as the root view controller.

```ruby
def reset_this_app
  open_root_screen HomeScreen
end
```

#### open(screen, args = {})

Opens a screen, intelligently determining the context.

**Examples:**

```ruby
# In app delegate
open HomeScreen.new(nav_bar: true)

# In tab bar
open HomeScreen.new(nav_bar: true), hide_tab_bar: true

# `modal: true` is the same as `open_modal`.
open ModalScreen.new(nav_bar: true), modal: true, animated: true

# Opening a modal screen with transition or presentation styles
open_modal ModalScreen.new(nav_bar: true,
    transition_style: UIModalTransitionStyleFlipHorizontal,
    presentation_style: UIModalPresentationFormSheet)

# From any screen (same as `open_root_screen`)
open HomeScreen.new(nav_bar: true), close_all: true

# Opening a screen in a different tab or split view screen
open DetailScreen.new, in_tab: "Tab name" # if you're in a tab bar
open MasterScreen, in_master: true # if you're in a split view (opened in current navigation controller if not)
open DetailScreen, in_detail: true # if you're in a split view (opened in current navigation controller if not)

# Opening a screen with a custom navigation_controller class. (Defaults to PM::NavigationController)
class MyNavigationController < PM::NavigationController; end
open HomeScreen.new(nav_bar: true, nav_controller: MyNavigationController), close_all: true

# Opens a screen with a navigation controller but with the navigation bar hidden
open HomeScreen.new(nav_bar: true, hide_nav_bar: true) # Edge feature
```

##### Setting screen accessors

Any writable attribute (accessor, setter methods etc.) in `screen` can also be set in the `new` hash argument.

```ruby
class HomeScreen < PM::Screen
  def profile_button_tapped
    open ProfileScreen.new(user: @current_user)
  end
end

class ProfileScreen < PM::Screen
  attr_accessor :user

  def on_load
    puts user # => @current_user object
  end
end
```

#### open_modal(screen, args = {})

Opens a modal screen. Same as `open HomeScreen, modal: true`

#### supported_orientation?(orientation)

Returns whether `UISupportedInterfaceOrientations` includes the given orientation.

```ruby
supported_orientation?(UIInterfaceOrientationMaskPortrait)
supported_orientation?(UIInterfaceOrientationMaskLandscapeLeft)
supported_orientation?(UIInterfaceOrientationMaskLandscapeRight)
supported_orientation?(UIInterfaceOrientationMaskPortraitUpsideDown)
```

#### supported_orientations

Returns the value for `UISupportedInterfaceOrientations`.

#### supported_device_families

Returns either `:iphone` or `:ipad`. Should probably be named `current_device_family` or something.

#### first_screen?

Boolean representing if this is the first screen in a navigation controller stack.

```ruby
def on_appear
  self.first_screen? # => true | false
end
```

---

### Class Methods

#### title(new_title)

Sets the default text title for all of the instances of this screen.

```ruby
class MyScreen < PM::Screen
  title "Some screen"
  # ...
end
```

#### title_view(new_title_view)

Sets an arbitrary view as the nav bar title.

```ruby
class MyScreen < PM::Screen
  title_view UILabel.new
  # ...
end
```

#### title_image(new_image)

Sets an arbitrary image as the nav bar title.

```ruby
class MyScreen < PM::Screen
  title_image "image.png"
  # ...
end
```

#### status_bar(style=nil, args={animation: UIStatusBarAnimationSlide})

Set the properties of the applications' status bar. Options for style are: `:none`, `:light` and `:default`. The animation argument should be a `UIStatusBarAnimation` (or `:none` / `:fade` / `:slide`) and is used to hide or show the status bar when appropriate and defaults to `:slide`.

```ruby
class MyScreen < PM::Screen
  status_bar :none, {animation: :fade}
  # ...
end

class MyScreenWithADarkColoredNavBar < PM::Screen
  status_bar :light
  # ...
end
```

#### nav_bar_button(position, button_options)

Creates a nav bar button in the specified position with the given options

```ruby
class HomeScreen < PM::Screen
  nav_bar_button :left, title: "Back", style: :plain, action: :back
  # ...
end
```

### Accessors

#### parent_screen

References the screen immediately before this one in a navigation controller *or* the presenting
screen for modals. You should set this yourself if you're doing something funky like `addChildViewController`.

```ruby
def on_appear
  self.parent_screen # => PM::Screen instance
end
```

The main view for this screen.

find.root_view
