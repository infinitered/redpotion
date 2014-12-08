class <%= @name_camel_case %>Screen < PM::<%= @screen_base %>
  title "Your title here"
  stylesheet <%= @name_camel_case %>ScreenStylesheet

  def on_load
  end
  <% if @screen_base == 'TableScreen' %>
  def table_data
    []
  end
  <% end %>

  # Remove the following if you're only using portrait

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
  def will_animate_rotate(orientation, duration)
    find.all.reapply_styles
  end
end
