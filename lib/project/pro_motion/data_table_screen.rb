module ProMotion
  class DataTableScreen < TableViewController
    include ProMotion::ScreenModule
    include ProMotion::DataTable

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

  end
end
