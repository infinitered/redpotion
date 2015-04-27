class ContributorScreen < PM::DataTableScreen
  title "RedPotion Contributors"
  stylesheet ContributorScreenStylesheet
  model Contributor

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
