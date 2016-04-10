class <%= @name_camel_case %>Screen < UITableViewController

  include ProMotion::ScreenModule

  title "Your title here"
  stylesheet <%= @name_camel_case %>ScreenStylesheet

  <%= @name.upcase %>_CELL_ID = "<%= @name_camel_case %>Cell"

  # Needed to be a ProMotion screen. Many controllers have different inits, so you need
  # to provide the correct one here
  def self.new(args = {})
    s = self.alloc.initWithStyle(UITableViewStylePlain)
    s.screen_init(args) if s.respond_to?(:screen_init)
    s
  end

  def on_load
    load_data

    table = view
    table.delegate = self
    table.dataSource = self
  end

  def load_data
    @data = 0.upto(rand(100)).map do |i| # Test data
      {
        name: %w(Lorem ipsum dolor sit amet consectetur adipisicing elit sed).sample,
        num: rand(100),
      }
    end
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

    cell = table_view.dequeueReusableCellWithIdentifier(<%= @name.upcase %>_CELL_ID) || begin
      rmq.create(<%= @name_camel_case %>Cell, :cell, reuse_identifier: <%= @name.upcase %>_CELL_ID).get

      # If you want to change the style of the cell, you can do something like this:
      #rmq.create(<%= @name_camel_case %>Cell, :cell, reuse_identifier: <%= @name.upcase %>_CELL_ID, cell_style: UITableViewCellStyleSubtitle).get
    end

    cell.update(data_row)
    cell
  end

  # You don't have to reapply styles to all UIViews, if you want to optimize, another way to do it
  # is tag the views you need to restyle in your stylesheet, then only reapply the tagged views, like so:
  #   def logo(st)
  #     st.frame = {t: 10, w: 200, h: 96}
  #     st.centered = :horizontal
  #     st.image = image.resource('logo')
  #     st.tag(:reapply_style)
  #   end
  #
  # Then in will_animate_rotate
  #   find(:reapply_style).reapply_styles#

  # Remove the following if you're only using portrait
  def will_animate_rotate(orientation, duration)
    reapply_styles
  end
  
end
