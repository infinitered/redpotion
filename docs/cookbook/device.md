# The device 

```ruby
device.screen
device.width # screen width
device.height # screen height
device.ipad?
device.iphone?
device.retina?

# Detect phone size?
device.three_point_five_inch?
device.four_inch?
device.four_point_seven_inch?
device.five_point_five_inch?

# Detect the iOS version
device.ios_version # "8.0" etc
device.is_version? "8.0" # be specific on minor versions
device.is_version? "8" # or just use the major version number
device.ios_at_least? 8 # iOS must be 8.0 or higher for true
device.ios_at_least? 8.1 # returns true if version is 8.1 or higher

# Are you in the simulator?
device.simulator?

# return values are :unknown, :portrait, :portrait_upside_down, :landscape_left,
# :landscape_right, :face_up, :face_down
device.orientation
device.landscape?
device.portrait?
```
