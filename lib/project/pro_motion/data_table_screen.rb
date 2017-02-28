module ProMotion
  class DataTableScreen < TableViewController

    include ProMotion::ScreenModule
    include ProMotion::DataTable

    class << self
      def model(value, opts = {})
        @opts = {
          model: value,
          scope: :all,
        }.merge(opts)
      end

      def data_model
        @opts[:model]
      end

      def data_scope
        @opts[:scope]
      end
    end

  end
end
