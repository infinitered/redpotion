class AppDelegate < PM::Delegate
  include CDQ
  status_bar true, animation: :fade

  def on_load(app, options)
    cdq.setup

    return true if RUBYMOTION_ENV == 'test'

    load_contributors

    open HomeScreen.new(nav_bar: true)
  end

  # Remove this if you are only supporting portrait
  def application(application, willChangeStatusBarOrientation: new_orientation, duration: duration)
    # Manually set RMQ's orientation before the device is actually oriented
    # So that we can do stuff like style views before the rotation begins
    device.orientation = new_orientation
  end

  def load_contributors
    contributors = %w{twerth squidpunch GantMan shreeve chunlea markrickert}

    if Contributor.count != contributors.count
      Contributor.destroy_all
      contributors.each do |c|
        Contributor.new(name: c)
      end
      cdq.save
    end
  end
end
