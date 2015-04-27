class <%= @name_camel_case %> < PM::TableViewCell
  def on_load
    apply_style :<%= @name %>

    content = find(self.contentView)
    @title = content.append! UILabel, :<%= @name %>_title

    # Add subviews here, like so:
    # content.append UILabel, :label_style_here
    # -or-
    # @submit_button = content.append(UIButton, :submit).get
    # -or-
    # @submit_button = content.append! UIButton, :submit
  end

  def title=(value)
    @title.text = value
  end
  def title
    @title
  end

end



__END__

You can use this like so in your table_screen:

  def table_data
    [
      {
        title: "Section",
        cells: [
          { cell_class: BarCell, height: stylesheet.bar_cell_height, title: "Foo"},
          { cell_class: BarCell, height: stylesheet.bar_cell_height, title: "Bar"}
        ]
      }
    ]
  end


To style this view include its stylesheet at the top of each controller's
stylesheet that is going to use it:

  class SomeStylesheet < ApplicationStylesheet
    include <%= @name_camel_case %>Stylesheet

Another option is to use your controller's stylesheet to style this view. This
works well if only one controller uses it. If you do that, delete the
view's stylesheet with:

  rm app/stylesheets/<%= @name %>_stylesheet.rb
