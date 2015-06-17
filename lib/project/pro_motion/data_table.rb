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

    # UITableViewDelegate methods
    def numberOfSectionsInTableView(_)
      fetch_controller.sections.count
    end

    def tableView(table_view, numberOfRowsInSection: section)
      fetch_controller.sections[section].numberOfObjects
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

    def on_cell_created(cell, data)
      # Do not call super here
      self.rmq.build(cell)
    end

    def tableView(_, willDisplayCell: table_cell, forRowAtIndexPath: index_path)
      data_cell = cell_at(index_path: index_path)
      table_cell.send(:will_display) if table_cell.respond_to?(:will_display)
      table_cell.send(:restyle!) if table_cell.respond_to?(:restyle!) # Teacup compatibility
    end

    def tableView(table_view, heightForRowAtIndexPath: index_path)
      (object_at_index(index_path).cell[:height] || table_view.rowHeight).to_f
    end

    def cell_at(args = {})
      index_path = args.is_a?(Hash) ? args[:index_path] : args
      c = object_at_index(index_path).cell        
      set_data_cell_defaults(c)
    end

    def controllerWillChangeContent(controller)
      table_view.beginUpdates
    end

    def controller(controller, didChangeObject: task, atIndexPath: index_path, forChangeType: change_type, newIndexPath: new_index_path)
      case change_type
      when NSFetchedResultsChangeInsert
        table_view.insertRowsAtIndexPaths([new_index_path], withRowAnimation: UITableViewRowAnimationAutomatic)
      when NSFetchedResultsChangeDelete
        table_view.deleteRowsAtIndexPaths([index_path], withRowAnimation: UITableViewRowAnimationAutomatic)
      when NSFetchedResultsChangeUpdate
        table_view.reloadRowsAtIndexPaths([index_path], withRowAnimation: UITableViewRowAnimationAutomatic)
      end
    end

    def controllerDidChangeContent(controller)
      table_view.endUpdates
    end

    def fetch_controller
      @_data ||= begin
        if respond_to?(:model_query)
          data_with_scope = model_query
        else
          data_with_scope = data_model.send(data_scope)
        end

        if data_with_scope.sort_descriptors.empty?
          # Try to be smart about how we sort things if a sort descriptor doesn't exist
          attributes = data_model.send(:attribute_names)
          sort_attribute = nil
          [:updated_at, :created_at, :id].each do |att|
            sort_attribute ||= att if attributes.include?(att.to_s)
          end

          if sort_attribute
            mp "The `#{data_model}` model scope `#{data_scope}` needs a sort descriptor. Add sort_by(:property) to your scope. Currently sorting by :#{sort_attribute}.", force_color: :yellow
            data_model.send(data_scope).sort_by(sort_attribute)
          else
            # This is where the application says goodbye and dies in a fiery crash.
            mp "The `#{data_model}` model scope `#{data_scope}` needs a sort descriptor. Add sort_by(:property) to your scope.", force_color: :yellow
          end
        else
          data_with_scope
        end
      end

      @fetch_controller ||= NSFetchedResultsController.alloc.initWithFetchRequest(
        @_data.fetch_request,
        managedObjectContext: @_data.context,
        sectionNameKeyPath: nil,
        cacheName: nil
      )
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

    def self.included(base)
      base.extend(TableClassMethods)
    end

  end
end
