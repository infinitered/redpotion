class AppDelegate < PM::Delegate
  include CDQ
  status_bar true, animation: :fade

  def on_load(app, options)
    cdq.setup

    load_contributers

    open HomeScreen.new(nav_bar: true)
  end

  # Remove this if you are only supporting portrait
  def application(application, willChangeStatusBarOrientation: new_orientation, duration: duration)
    # Manually set RMQ's orientation before the device is actually oriented
    # So that we can do stuff like style views before the rotation begins
    device.orientation = new_orientation
  end

  def load_contributers
    contributers = %w{twerth squidpunch GantMan shreeve chunlea markrickert}

    if Contributer.count != contributers.count
      Contributer.destroy_all
      contributers.each do |c|
        Contributer.new(name: c)
      end
      cdq.save
    end
  end
end
