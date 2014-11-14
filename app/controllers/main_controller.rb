class MainController < UIViewController

  def viewDidLoad
    super

    self.title = 'redpotion'

    rmq.stylesheet = MainStylesheet
    rmq(self.view).apply_style :root_view

    #TODO insert custom plugin functionality
  end

  def supportedInterfaceOrientations
    UIInterfaceOrientationMaskAll
  end
  def willAnimateRotationToInterfaceOrientation(orientation, duration: duration)
    rmq.all.reapply_styles
  end
end
