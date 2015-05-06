module ProMotion
  class TableScreen < TableViewController
    def on_cell_created(cell, data)
      build(cell)
    end
  end
end
