module ProMotion
  class DataTableScreen < TableScreen
    class << self
      def model(value, scope=nil)
        if value.method_defined?(:cell)
          @data_model = value
          @data_scope = scope || :all
        else
          raise "#{value} must define the cell method"
        end
      end

      def data_model; @data_model; end
      def data_scope; @data_scope; end
    end

    def table_data
      [{
        cells: cell_data
      }]
    end

    def cell_data
      return [] if data_model.nil?

      data_model.send(data_scope).collect(&:cell)
    end

    private

    def data_model
      self.class.data_model
    end

    def data_scope
      self.class.data_scope
    end
  end
end
