class DataTableSeachDelegate
  attr_accessor :parent

  # UISearchControllerDelegate methods

  def willPresentSearchController(search_controller)
    parent.dt_searchDisplayControllerWillBeginSearch(search_controller)
  end

  def willDismissSearchController(search_controller)
    parent.dt_searchDisplayControllerWillEndSearch(search_controller)
  end

  # UISearchResultsUpdating protocol method
  def updateSearchResultsForSearchController(search_controller)
    search_string = search_controller.searchBar.text
    parent.dt_searchDisplayController(search_controller, shouldReloadTableForSearchString: search_string) if @_data_table_searching
  end
end
