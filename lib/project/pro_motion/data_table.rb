module ProMotion
  module DataTable

    include TableClassMethods
    include ProMotion::Styling
    include ProMotion::Table
    include ProMotion::TableBuilder
    include ProMotion::TableDataBuilder
    include ProMotion::Table::Utils

    include ProMotion::Table::Searchable
    include ProMotion::Table::Refreshable
    include ProMotion::Table::Indexable
    include ProMotion::Table::Longpressable

    def table_view
      self.view
    end

    # This has to be defined in order to inherit everything from TableScreen
    def table_data
      [{cells:[]}]
    end

    def screen_setup
      set_up_fetch_controller

      set_up_header_footer_views
      set_up_searchable
      set_up_refreshable
      set_up_longpressable
      set_up_row_height
    end

    def set_up_fetch_controller
      error_ptr = Pointer.new(:object)
      fetch_controller.delegate = self

      unless fetch_controller.performFetch(error_ptr)
        raise "Error performing fetch: #{error_ptr[2].description}"
      end
    end

    def update_table_data(notification = nil)
      if notification.nil?
        table_view.reloadData
      else
        Dispatch::Queue.main.async do
          fetch_controller.managedObjectContext.mergeChangesFromContextDidSaveNotification(notification)
        end
      end
    end

    def fetch_scope
      @_fetch_scope ||= begin
        if respond_to?(:model_query)
          data_with_scope = model_query
        else
          data_with_scope = data_model.send(data_scope)
        end

        if data_with_scope.sort_descriptors.blank?
          # Try to be smart about how we sort things if a sort descriptor doesn't exist
          attributes = data_model.send(:attribute_names)
          sort_attribute = nil
          [:updated_at, :created_at, :id].each do |att|
            sort_attribute ||= att if attributes.include?(att.to_s)
          end

          if sort_attribute

            unless data_scope == :all
              mp "The `#{data_model}` model scope `#{data_scope}` needs a sort descriptor. Add sort_by(:property) to your scope. Currently sorting by :#{sort_attribute}.", force_color: :yellow
            end
            data_with_scope.sort_by(sort_attribute)
          else
            # This is where the application says goodbye and dies in a fiery crash.
            mp "The `#{data_model}` model scope `#{data_scope}` needs a sort descriptor. Add sort_by(:property) to your scope.", force_color: :yellow
          end
        else
          data_with_scope
        end
      end
    end

    def fetch_controller
      if searching?
        search_fetch_controller
      else
        @fetch_controller ||= NSFetchedResultsController.alloc.initWithFetchRequest(
          fetch_scope.fetch_request,
          managedObjectContext: fetch_scope.context,
          sectionNameKeyPath: nil,
          cacheName: nil
        )
      end
    end

    def refresh_scope
      @fetch_controller = @_fetch_scope = nil
      set_up_fetch_controller
      update_table_data
    end

    def on_cell_created(cell, data)
      # Do not call super here
      self.rmq.build(cell)
    end

    def cell_at(args = {})
      index_path = args.is_a?(Hash) ? args[:index_path] : args
      c = cell_for object_at_index(index_path)
      set_data_cell_defaults(c)
    end

    def cell_for model
      begin
        self.respond_to?(:cell) ? cell(model) : model.cell
      rescue NoMethodError
        raise "Either #{model} or #{self} must define the cell method."
      end
    end

    def object_at_index(i)
      fetch_controller.objectAtIndexPath(i)
    end

    def data_model
      self.class.data_model
    end

    def data_scope
      self.class.data_scope
    end

    def searching?
      @_data_table_searching || false
    end

    def search_string
      @_data_table_search_string
    end

    def original_search_string
      search_string
    end

    def self.included(base)
      base.extend(TableClassMethods)
    end

    # UITableViewDelegate methods
    def numberOfSectionsInTableView(_)
      fetch_controller.sections.count
    end

    def tableView(table_view, numberOfRowsInSection: section)
      #schedule a callback on the next event loop letting the controller know all rows have been loaded in the background
      #the only way to get this is on the LAST invocation of this delegate method. A little hacky, but Apple missed this one from the SDK.
      NSObject.cancelPreviousPerformRequestsWithTarget(self, selector: 'on_rows_loaded:', object:tableView) #this is not the last invocation
      self.performSelector('on_rows_loaded:', withObject: table_view, afterDelay:0) #this one will be after the last, if not cancelled

      fetch_controller.sections[section].numberOfObjects
    end

    #default implementation; override
    def on_rows_loaded table_view
    end

    def tableView(table_view, didSelectRowAtIndexPath: index_path)
      data_cell = cell_at(index_path: index_path)
      table_view.deselectRowAtIndexPath(index_path, animated: true) unless data_cell[:keep_selection] == true
      trigger_action(data_cell[:action], data_cell[:arguments], index_path) if data_cell[:action]
    end

    def tableView(_, cellForRowAtIndexPath: index_path)
      params = index_path_to_section_index(index_path: index_path)
      data_cell = cell_at(index_path: index_path)
      return self.rmq.create(UITableViewCell) unless data_cell

      create_table_cell(data_cell)
    end

    def tableView(_, willDisplayCell: table_cell, forRowAtIndexPath: index_path)
      data_cell = cell_at(index_path: index_path)
      try :will_display_cell, table_cell, index_path
      table_cell.send(:will_display) if table_cell.respond_to?(:will_display)
      table_cell.send(:restyle!) if table_cell.respond_to?(:restyle!) # Teacup compatibility
    end

    def tableView(table_view, heightForRowAtIndexPath: index_path)
      (cell_for(object_at_index(index_path))[:height] || table_view.rowHeight).to_f
    end

    def controllerWillChangeContent(controller)
      # TODO - we should update the search results table when a new record is added
      # or deleted or changed. For now, when the data changes, the search doesn't
      # update. Closing the search will update the data and then searching again
      # will show the new or changed content.
      table_view.beginUpdates unless searching?
    end

    def controller(controller, didChangeObject: task, atIndexPath: index_path, forChangeType: change_type, newIndexPath: new_index_path)
      unless searching?
        case change_type
        when NSFetchedResultsChangeInsert
          table_view.insertRowsAtIndexPaths([new_index_path], withRowAnimation: UITableViewRowAnimationAutomatic)
        when NSFetchedResultsChangeDelete
          table_view.deleteRowsAtIndexPaths([index_path], withRowAnimation: UITableViewRowAnimationAutomatic)
        when NSFetchedResultsChangeUpdate
          table_view.reloadRowsAtIndexPaths([index_path], withRowAnimation: UITableViewRowAnimationAutomatic)
        end
      end
    end

    def controllerDidChangeContent(controller)
      table_view.endUpdates unless searching?
    end

  end
end
