class ApplicationStylesheet < RubyMotionQuery::Stylesheet

  def application_setup

    # Change the default grid if desired
    #   rmq.app.grid.tap do |g|
    #     g.num_columns =  12
    #     g.column_gutter = 10
    #     g.num_rows = 18
    #     g.row_gutter = 10
    #     g.content_left_margin = 10
    #     g.content_top_margin = 74
    #     g.content_right_margin = 10
    #     g.content_bottom_margin = 10
    #   end

    # An example of setting standard fonts and colors
    font_family = 'Helvetica Neue'
    font.add_named :large,    font_family, 36
    font.add_named :medium,   font_family, 24
    font.add_named :small,    font_family, 16
    font.add_named :tiny,     font_family, 13

    color.add_named :tint, '236EB7'
    color.add_named :translucent_black, color.from_rgba(0, 0, 0, 0.4)
    color.add_named :battleship_gray,   '#7F7F7F'
  end

end
