module ProMotion
  class DataTableScreen < TableScreen

    def self.cell(cell)
      @cell = cell
    end

    def self.cell_properties
      @cell
    end

    def table_data
      [{
        cells: cell_data
      }]
    end

    def cell_properties
      self.class.cell_properties
    end

    def cell_data
      return [] if cell_properties.nil?
      return [] if data_model.nil?

      data_model.send(data_scope).collect do |c|
        if c.respond_to?(:cell)
          c.cell
        else
          {
            cell_class: cell_class,
            properties: properties.inject({}) do |hash, element|
              hash[element.first] = c.send(element.last)
              hash
            end
          }
        end
      end
    end

    private

    def properties
      @properties ||= cell_properties[:template].reject do |k,v|
        k == :cell_class
      end unless cell_properties[:template].nil?
    end

    def cell_class
      @cell_class ||= cell_properties[:template].nil? ? nil : cell_properties[:template][:cell_class]
    end

    def data_model
      @data_model ||= cell_properties[:model]
    end

    def data_scope
      @data_scope ||= cell_properties[:scope] || :all
    end
  end
end
