module ProMotion
  class DataTableScreen < TableScreen
    class << self
      def model(value, opts = {})
        if value.method_defined?(:cell)
          @opts = {
            model: value,
            scope: :all,
          }.merge(opts)
        else
          raise "#{value} must define the cell method"
        end
      end

      def data_model; @opts[:model]; end
      def data_scope; @opts[:scope]; end
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
