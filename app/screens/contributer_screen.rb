class ContributerScreen < PM::DataTableScreen
  title "RedPotion Contributers"
  refreshable
  stylesheet ContributerScreenStylesheet
  model Contributer

  def on_load
  end

  def on_refresh
    stop_refreshing
  end

  # Remove if you are only supporting portrait
  def will_animate_rotate(orientation, duration)
    reapply_styles
  end
end
