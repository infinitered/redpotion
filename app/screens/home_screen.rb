class HomeScreen < PM::Screen
  title "RedPotion"
  stylesheet HomeScreenStylesheet

  def on_load
    set_nav_bar_button :left, system_item: :camera, action: :nav_left_button
    set_nav_bar_button :right, title: "Right", action: :nav_right_button

    @hello_world_label = append!(UILabel, :hello_world)
    append HelloWorldSection # Section will handle its own styling

    append(UIButton, :open_table_button).on(:touch) do
      open TasksScreen.new(nav_bar: true)
    end

    append(UIButton, :open_metal_table_button).on(:touch) do
      open MetalTableScreen.new(nav_bar: true)
    end

    append(UIButton, :open_data_table_button).on(:touch) do
      open ContributorScreen.new(nav_bar: true)
    end

    append(UIButton, :open_example_controller_button).on(:touch) do
      open ExampleController
    end
  end

  def nav_left_button
    mp 'Left button'
    append(UIImageView, :grumpy_image)
  end

  def nav_right_button
    mp 'Right button'
  end

  # You don't have to reapply styles to all UIViews, if you want to optimize,
  # another way to do it is tag the views you need to restyle in your stylesheet,
  # then only reapply the tagged views, like so:
  # def logo(st)
  #   st.frame = {t: 10, w: 200, h: 96}
  #   st.centered = :horizontal
  #   st.image = image.resource('logo')
  #   st.tag(:reapply_style)
  # end
  #
  # # Then in will_animate_rotate
  # find(:reapply_style).reapply_styles
  def will_animate_rotate(orientation, duration)
    reapply_styles
  end
end
