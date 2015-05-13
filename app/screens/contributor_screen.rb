class ContributorScreen < PM::DataTableScreen
  title "RedPotion Contributors"
  stylesheet ContributorScreenStylesheet
  model Contributor
  refreshable

  def on_load
    @refreshed = false
  end

  def on_refresh
    stop_refreshing
    @refreshed = true
  end

  # Remove if you are only supporting portrait
  def will_animate_rotate(orientation, duration)
    reapply_styles
  end
end
