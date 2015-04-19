## Get to the app delegate from anywhere in the app

```ruby
app.delegate.some_method_you_added
```

## About the app delegate

RedPotion uses the PM::Delegate from ProMotion, which has a nice API for your AppDelegate class.

```ruby
# app/app_delegate.rb
class AppDelegate < PM::Delegate
  status_bar false, animation: :none

  def on_load(app, options)
    open HomeScreen.new(nav_bar: true)
  end
end
```

If you need to inherit from a different AppDelegate superclass, do this:

```ruby
class AppDelegate < JHMyParentDelegate
  include PM::DelegateModule
  status_bar false, animation: :none

  def on_load(app, options)
    open HomeScreen.new(nav_bar: true)
  end
end
```

### Methods

#### on_load(app, options)

Main method called when starting your app. Open your first screen, tab bar, or split view here.

```ruby
def on_load(app, options)
  open HomeScreen
end
```

#### on_unload

Fires when the app is about to terminate. Don't do anything crazy here, but it's a last chance
to save state if necessary.

```ruby
def on_unload
  # Unloading!
end
```

#### will_load(app, options)

Fired just before the app loads. Not usually necessary.

#### will_deactivate

Fires when the app is about to become inactive.

#### on_activate

Fires when the app becomes active.

#### will_enter_foreground

Fires just before the app enters the foreground.

#### on_enter_background

Fires when the app enters the background.

#### open_tab_bar(*screens)

Opens a UITabBarController with the specified screens as the root view controller of the current app.
iOS doesn't allow opening a UITabBar as a sub-view.

```ruby
def on_load(app, options)
  open_tab_bar HomeScreen, AboutScreen, ThirdScreen, HelpScreen
end
```

#### open_split_screen(master, detail)

**iPad apps only**

Opens a UISplitScreenViewController with the specified screens as the root view controller of the current app

```ruby
def on_load(app, options)
  open_split_screen MasterScreen, DetailScreen,
    icon: "split-icon", title: "Split Screen Title" # optional
end
```

#### on_open_url(args = {})

Fires when the application is opened via a URL (utilizing [application:openURL:sourceApplication:annotation:](http://developer.apple.com/library/ios/#documentation/uikit/reference/UIApplicationDelegate_Protocol/Reference/Reference.html#//apple_ref/occ/intfm/UIApplicationDelegate/application:openURL:sourceApplication:annotation:)).

```ruby
def on_open_url(args = {})
  args[:url]        # => the URL used to fire the app (NSURL)
  args[:source_app] # => the bundle ID of the app that is launching your app (string)
  args[:annotation] # => hash with annotation data from the source app
end
```

---

### Class Methods

#### status_bar

Class method that allows hiding or showing the status bar.

```ruby
class AppDelegate < PM::Delegate
  status_bar true, animation: :none # :slide, :fade
end
```

#### tint_color

Class method that allows you to set the application's global tint color for iOS 7 apps.

```ruby
class AppDelegate < ProMotion::Delegate
  tint_color UIColor.greenColor
end
```

