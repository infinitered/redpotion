module ProMotion
  module Table
    module Searchable

      def make_data_table_searchable(params={})
        if params[:search_bar][:fields].nil?
          raise "ERROR: You must specify fields:[:example] for your searchable DataTableScreen. It should be an array of fields you want searched in CDQ."
        else
          @data_table_predicate_fields = params[:search_bar][:fields]
        end
        params[:delegate] = search_delegate

        make_searchable(params)
      end

      def search_fetch_controller
        @_search_fetch_controller ||= new_frc_with_search(search_string)
      end

      def new_frc_with_search(search_string)
        return if @data_table_predicate_fields.blank?

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
        search.delegate = search_delegate

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

      def search_delegate
        @_search_delegate ||= begin
          d = DataTableSeachDelegate.new
          d.parent = WeakRef.new(self)
          d
        end
      end

      ######### iOS methods, headless camel case #######

      def dt_searchDisplayController(controller, shouldReloadTableForSearchString:search_string)
        @_data_table_search_string = search_string
        reset_search_frc
        true
      end

      def dt_searchDisplayControllerWillEndSearch(controller)
        @_data_table_searching = false
        @_search_fetch_controller.delegate = nil unless @_search_fetch_controller.nil?
        @_search_fetch_controller = nil
        @_data_table_search_string = nil
        self.table_view.setScrollEnabled true
        @table_search_display_controller.delegate.will_end_search if @table_search_display_controller.delegate.respond_to? "will_end_search"
        update_table_data
      end

      def dt_searchDisplayControllerWillBeginSearch(controller)
        @_data_table_searching = true
        self.table_view.setScrollEnabled false
        @table_search_display_controller.delegate.will_begin_search if @table_search_display_controller.delegate.respond_to? "will_begin_search"
      end
    end
  end
end
