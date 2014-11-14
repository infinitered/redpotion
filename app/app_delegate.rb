class AppDelegate
  attr_reader :window

  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)

    main_controller = MainController.new
    @window.rootViewController = UINavigationController.alloc.initWithRootViewController(main_controller)

    @window.makeKeyAndVisible
    true
  end
end
