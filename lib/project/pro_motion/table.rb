module ProMotion
  class TableScreen < TableViewController
    # Don't call super -- would result in two on_load calls to the cell.
    def on_cell_created(cell, data)
      self.rmq.build(cell)
    end
  end

  # This is duplicated from ProMotion in order to be call
  # make_data_table_searchable instead of make_searchable
  # module Table
  #   def set_up_searchable
  #     if self.class.respond_to?(:get_searchable) && self.class.get_searchable
  #       if self.is_a?(ProMotion::DataTableScreen)
  #         self.make_data_table_searchable(content_controller: self, search_bar: self.class.get_searchable_params)
  #       else
  #         self.make_searchable(content_controller: self, search_bar: self.class.get_searchable_params)
  #       end
  #       if self.class.get_searchable_params[:hide_initially]
  #         self.tableView.contentOffset = CGPointMake(0, self.searchDisplayController.searchBar.frame.size.height)
  #       end
  #     end
  #   end
  # end

end
