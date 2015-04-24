module ProMotion
  module DataTable
    include ProMotion::Styling
    include ProMotion::Table::Utils

    def table_view
      self.view
    end

    def screen_setup
      set_up_reload_notification
      set_up_fetch_controller

      # TODO - implement dynamic row height
      # set_up_row_height
    end

    def set_up_reload_notification
      NSNotificationCenter.defaultCenter.addObserver(self,
        selector: "update_table_data:",
        name: NSManagedObjectContextDidSaveNotification,
        object: nil)
    end

    def set_up_fetch_controller
      error_ptr = Pointer.new(:object)
      fetch_controller.delegate = self

      unless fetch_controller.performFetch(error_ptr)
        raise "Error performing fetch: #{error_ptr[2].description}"
      end
    end

    def update_table_data(notification = nil)
      data_model.send(:update) if data_model.respond_to?(:update)
      Dispatch::Queue.main.async do
        fetch_controller.managedObjectContext.mergeChangesFromContextDidSaveNotification(notification)
      end
    end

    # UITableViewDelegate methods
    def tableView(table_view, numberOfRowsInSection: section)
      fetch_controller.sections[section].numberOfObjects
    end

    def tableView(table_view, heightForRowAtIndexPath: index_path)
      (object_at_index(index_path).cell[:height] || table_view.rowHeight).to_f
    end

    def tableView(table_view, didSelectRowAtIndexPath: index_path)
      data_cell = cell_at(index_path)
      table_view.deselectRowAtIndexPath(index_path, animated: true) unless data_cell[:keep_selection] == true
      trigger_action(data_cell[:action], data_cell[:arguments], index_path) if data_cell[:action]
    end

    def tableView(_, cellForRowAtIndexPath: index_path)
      params = index_path_to_section_index(index_path: index_path)
      data_cell = cell_at(index_path)
      return UITableViewCell.alloc.init unless data_cell
      create_table_cell(data_cell)
    end

    def cell_at(index_path)
      c = object_at_index(index_path).cell
      set_data_cell_defaults c
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
        data_with_scope = data_model.send(data_scope)
        if data_with_scope.sort_descriptors.empty?
          # Try to be smart about how we sort things if a sort descriptor doesn't exist
          attributes = data_model.send(:attribute_names)
          sort_attribute = nil
          [:updated_at, :created_at, :id].each do |att|
            sort_attribute ||= att if attributes.include?(att.to_s)
          end

          if sort_attribute
            PM.logger.warn("The `#{data_model}` model scope `#{data_scope}` needs a sort descriptor. Add sort_by(:property) to your scope. Currently sorting by :#{sort_attribute}.")
            data_model.send(data_scope).sort_by(sort_attribute)
          else
            # This is where the application says goodbye and dies in a fiery crash.
            PM.logger.error("The `#{data_model}` model scope `#{data_scope}` needs a sort descriptor. Add sort_by(:property) to your scope.")
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

    # TODO - extract these methods out from Promotion into a module perhaps?
    def create_table_cell(data_cell)
      new_cell = nil
      table_cell = table_view.dequeueReusableCellWithIdentifier(data_cell[:cell_identifier]) || begin
        new_cell = data_cell[:cell_class].alloc.initWithStyle(data_cell[:cell_style], reuseIdentifier:data_cell[:cell_identifier])
        new_cell.extend(PM::TableViewCellModule) unless new_cell.is_a?(PM::TableViewCellModule)
        new_cell.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin
        new_cell.clipsToBounds = true # fix for changed default in 7.1
        new_cell.send(:on_load) if new_cell.respond_to?(:on_load)
        new_cell
      end
      table_cell.setup(data_cell, self) if table_cell.respond_to?(:setup)
      table_cell.send(:on_reuse) if !new_cell && table_cell.respond_to?(:on_reuse)
      table_cell
    end

    def set_data_cell_defaults(data_cell)
      data_cell[:cell_style] ||= begin
        data_cell[:subtitle] ? UITableViewCellStyleSubtitle : UITableViewCellStyleDefault
      end
      data_cell[:cell_class] ||= PM::TableViewCell
      data_cell[:cell_identifier] ||= build_cell_identifier(data_cell)
      data_cell[:properties] ||= data_cell[:style] || data_cell[:styles]

      data_cell[:accessory] = {
        view: data_cell[:accessory],
        value: data_cell[:accessory_value],
        action: data_cell[:accessory_action],
        arguments: data_cell[:accessory_arguments]
      } unless data_cell[:accessory].nil? || data_cell[:accessory].is_a?(Hash)

      data_cell
    end

    def build_cell_identifier(data_cell)
      ident = "#{data_cell[:cell_class].to_s}"
      ident << "-#{data_cell[:stylename].to_s}" if data_cell[:stylename] # For Teacup
      ident << "-accessory" if data_cell[:accessory]
      ident << "-subtitle" if data_cell[:subtitle]
      ident << "-remoteimage" if data_cell[:remote_image]
      ident << "-image" if data_cell[:image]
      ident
    end
    # end TODO

    def data_model
      self.class.data_model
    end

    def data_scope
      self.class.data_scope
    end

    # TODO - TableClassMethods class after it's extracted to it's own module file in ProMotion.
    module DataTableClassMethods
      def table_style
        UITableViewStylePlain
      end
    end

    def self.included(base)
      base.extend(DataTableClassMethods)
    end

  end
end
