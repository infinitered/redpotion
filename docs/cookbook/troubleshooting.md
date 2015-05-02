## Troubleshooting

### The Nuclear Option

Running `rake` was working perfectly last night, but this morning, you are getting mysterious errors, such as

````Simulator session started with error: Error Domain=NSPOSIXErrorDomain Code=3 "Failed to lookup the process ID of com.your_domain_here.my_awesome_app after successful launch.  Perhaps it crashed after launch."````

Your environment might be borked. Try this:

`rake newclear`

The nuke task performs the following operations:

````
Cleaning Project...
    Delete ./build
    Delete ./resources/my_awesome_app.momd
    Delete /Users/<your user>/.rvm/gems/ruby-2.1.1/gems/cdq-1.0.2/lib/../vendor/cdq/ext/build-iPhoneSimulator
     Clean ./Pods.xcodeproj for platform `iPhoneSimulator'
     Clean ./Pods.xcodeproj for platform `iPhoneOS'
    Delete vendor/Pods/build-iPhoneSimulator
    Delete /Users/<your user>/Library/RubyMotion/build
    Delete vendor/Pods

Resetting simulator...

Bundling...

Setting up cocoapods...

Installing cocoapod dependencies...

rake
````

Most of the items (other than rvm gems and `/Users/<your user>/Library/RubyMotion/build`) that are deleted and cleaned exist within your current project directory. Nuking your project is a benign operation. since running `rake` rebuilds everything that was nuked, so give it a try.

### Corrupt/missing Cocoapods Specs repository

You run `rake pm:install` on a freshly created redpotion app and it hangs on `Updating spec repo master`. Presumably, you've already run `pod setup` one time on your machine, so what gives?

If you see an error message about pod not being able to find the master spec repo when you run `rake pm:install --verbose`, you can perform a clean pod setup:

````
> pod repo remove master
> pod setup

````
Now you should be able to run rake pm:install.





