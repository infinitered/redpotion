module ProMotion
  #TODO ? - set_attributes is called twice - seems like this is in PM core
  # this is because we call setup when we build the cell and setup when its
  # about to display - this is because PM wants styling to fire in each case -
  # and properties was where the styling is done in PM
  #
  # if we are going to wire an event when a value is set on a cell, this could
  # be problematic, especially likely since cells are reused, etc
  # see my new cell for example, where I have to remove and then add events
  # because of the double call

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
        {
          cell_class: cell_class,
          properties: properties.inject({}) do |hash, element|
            hash[element.first] = c.send(element.last)
            hash
          end
        }
      end
    end

    private

    def properties
      @properties ||= cell_properties[:template].reject do |k,v|
        k == :cell_class
      end
    end

    def cell_class
      @cell_class ||= cell_properties[:template][:cell_class]
    end

    def data_model
      @data_model ||= cell_properties[:model]
    end

    def data_scope
      @data_scope ||= cell_properties[:scope] || :all
    end
  end
end
