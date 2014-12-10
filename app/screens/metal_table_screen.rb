class MetalTableScreen < UITableViewController
  include ProMotion::ScreenModule

  title "Down to the metal table"
  stylesheet MetalTableScreenStylesheet
  CELL_ID = "MetalTableCell"

  # Needed to be a ProMotion screen. Many controllers have different inits, so you need
  # to provide the correct one here
  def self.new(args = {})
    s = self.alloc.initWithStyle(UITableViewStylePlain)
    s.screen_init(args) if s.respond_to?(:screen_init)
    s
  end

  def on_load
    load_data
    view.tap do |table|
      table.delegate = self
      table.dataSource = self
    end
  end

  def load_data
    @data = 0.upto(rand(1000)).map do |i| # Test data
      {
        name: %w(Lorem ipsum dolor sit amet consectetur adipisicing elit sed).sample,
        num: rand(100),
      }
    end
  end

  # Remove if you are only supporting portrait
  def will_animate_rotate(orientation, duration)
    reapply_styles
  end

  # Standard table stuff
  def tableView(table_view, numberOfRowsInSection: section)
    @data.length
  end

  def tableView(table_view, heightForRowAtIndexPath: index_path)
    stylesheet.cell_height
  end

  def tableView(table_view, cellForRowAtIndexPath: index_path)
    data_row = @data[index_path.row]

    cell = table_view.dequeueReusableCellWithIdentifier(CELL_ID) || begin
      create!(MetalTableCell, :cell, reuse_identifier: CELL_ID)
    end

    cell.update(data_row)
    cell
  end
end
