class DataTableSeachDelegate
  attr_accessor :parent

  def searchDisplayController(controller, shouldReloadTableForSearchString:search_string)
    parent.dt_searchDisplayController(controller, shouldReloadTableForSearchString:search_string)
  end

  def searchDisplayControllerWillEndSearch(controller)
    parent.dt_searchDisplayControllerWillEndSearch(controller)
  end

  def searchDisplayControllerWillBeginSearch(controller)
    parent.dt_searchDisplayControllerWillBeginSearch(controller)
  end
end
