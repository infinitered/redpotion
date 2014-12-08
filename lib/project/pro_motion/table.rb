module ProMotion
  class TableScreen < TableViewController

    # Temporarily here until this is added to ProMotion
    def create_table_cell(data_cell)
      new_cell = nil
      table_cell = table_view.dequeueReusableCellWithIdentifier(data_cell[:cell_identifier]) || begin
        new_cell = data_cell[:cell_class].alloc.initWithStyle(data_cell[:cell_style], reuseIdentifier:data_cell[:cell_identifier])
        new_cell.extend(PM::TableViewCellModule) unless new_cell.is_a?(PM::TableViewCellModule)
        new_cell.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin
        new_cell.clipsToBounds = true # fix for changed default in 7.1
        new_cell.send(:on_load) if new_cell.respond_to?(:on_load)
        new_cell.setup(data_cell, self)
        new_cell
      end
      table_cell.send(:on_reuse) if !new_cell && table_cell.respond_to?(:on_reuse)
      table_cell
    end
  end

end
