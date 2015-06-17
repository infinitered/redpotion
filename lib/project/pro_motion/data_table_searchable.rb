module ProMotion
  module Table
    module Searchable

      # Replace this method so that we can gather the predicate fields for DataTableScreen searchable
      alias_method :old_set_searchable_param_defaults, :set_searchable_param_defaults
      def set_searchable_param_defaults(params)
        all_params = old_set_searchable_param_defaults(params)

        if self.is_a?(ProMotion::DataTableScreen)
          if params[:search_bar][:fields].nil?
            raise "ERROR: You must specify fields:[:example] for your searchable DataTableScreen. It should be an array of fields you want searched in CDQ."
          else
            @data_table_predicate_fields = all_params[:search_bar].delete(:fields)
          end
        end

        all_params
      end

      def search_fetch_controller
        @_search_fetch_controller ||= new_frc_with_search(self.tableView.tableHeaderView.text)
      end

      def new_frc_with_search(search_string)
        # Create the predicate from the predetermined fetch scope.
        where = @data_table_predicate_fields.map{|f| "#{f} CONTAINS[cd] \"#{search_string}\"" }.join(" OR ")
        search_scope = fetch_scope.where(where)

        # Create the search FRC with the predicate and set delegate
        search = NSFetchedResultsController.alloc.initWithFetchRequest(
          search_scope.fetch_request,
          managedObjectContext: search_scope.context,
          sectionNameKeyPath: nil,
          cacheName: nil
        )
        search.delegate = self

        # Perform the fetch
        error_ptr = Pointer.new(:object)
        unless search.performFetch(error_ptr)
          raise "Error performing fetch: #{error_ptr[2].description}"
        end

        search
      end

      def reset_search_frc
        # Update the filter, in this case just blow away the FRC and let
        # lazy evaluation create another with the relevant search info
        @_search_fetch_controller.delegate = nil unless @_search_fetch_controller.nil?
        @_search_fetch_controller = nil
      end

      ######### iOS methods, headless camel case #######

      def searchDisplayController(controller, shouldReloadTableForSearchString:search_string)
        @_data_table_search_string = search_string
        reset_search_frc
        true
      end

      def searchDisplayControllerWillEndSearch(controller)
        @_data_table_searching = false
        @_search_fetch_controller.delegate = nil unless @_search_fetch_controller.nil?
        @_search_fetch_controller = nil
        self.table_view.setScrollEnabled true
        @table_search_display_controller.delegate.will_end_search if @table_search_display_controller.delegate.respond_to? "will_end_search"
      end

      def searchDisplayControllerWillBeginSearch(controller)
        @_data_table_searching = true
        self.table_view.setScrollEnabled false
        @table_search_display_controller.delegate.will_begin_search if @table_search_display_controller.delegate.respond_to? "will_begin_search"
      end
    end
  end
end
