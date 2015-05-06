module ProMotion
  class TableScreen < TableViewController
    # Don't call super -- would result in two on_load calls to the cell.
    def on_cell_created(cell, data)
      build(cell)
    end
  end
end
