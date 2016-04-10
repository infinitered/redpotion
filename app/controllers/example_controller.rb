# It's prefered you use a screen. But you can also use normal controllers. If you want
# to turn any controller into a screen, see metal_table_screen for an example.
class ExampleController < UIViewController

  # You can't use any of the ProMotion screen stuff here, but you can use the RedPotion stuff, and
  # RedPotion adds stuff like on_load to normal controllers. It also has all the rmq shortcuts

  stylesheet ExampleControllerStylesheet

  def on_load
    # You cannot use title above 'stylesheet' because that is a PM feature
    self.title = "Example controller"

    append UILabel, :hello_world
  end

  def will_animate_rotate(orientation, duration)
    reapply_styles
  end
  
end
