## What is the app name and indentifier?

```ruby
app.name
app.identifier
```

## Can I find out info about for the project at runtime?

This only works in development environment:
```ruby
RubyMotionQuery::RMQ.build_time # Date/time when the app was last built
RubyMotionQuery::RMQ.project_path
```


## What are paths for the running app?

```ruby
app.resource_path
app.document_path
```


# Is the app running in Dev or Release (production)?

```ruby
app.environment
app.release? # .production? also
app.test?
app.development?
```

# Is the app in the simulator?

```ruby
device.simulator?
```

## What kind of device is the app running on?

```ruby
device.ipad?
device.iphone?
```

## What size phone or other device is the app running on?

```ruby
device.width # this does not change with orientation, use screen_width for that 
device.height # this does not change with orientation, use screen_height for that 
device.screen_width
device.screen_height

device.retina?
device.three_point_five_inch?
device.four_inch?
device.four_point_seven_inch?
device.five_point_five_inch?
```

## Which OS is it running?

```ruby
# Detect the iOS version
device.ios_version # "8.0" etc
device.is_version? "8.0" # be specific on minor versions
device.is_version? "8" # or just use the major version number
device.ios_at_least? 8 # iOS must be 8.0 or higher for true
device.ios_at_least? 8.1 # returns true if version is 8.1 or higher
```

## What orientation is it currently in?

```ruby
device.landscape?
device.portrait?

# return values are :unknown, :portrait, :portrait_upside_down, :landscape_left,
# :landscape_right, :face_up, :face_down
device.orientation
```
