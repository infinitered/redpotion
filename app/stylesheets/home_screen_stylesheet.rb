class HomeScreenStylesheet < ApplicationStylesheet

  def root_view(st)
    st.background_color = color.white
  end

  # hello_world(st)
  # Defined in ApplicationStylesheet

  def section(st)
    st.frame = {t: 100, w: 200, h: 100, centered: :horizontal}
    st.background_color = color.light_gray
  end

  def section_button(st)
    st.frame = {l: 5, t: 5, w: 80, h: 20}
    st.text = "Button"
    st.background_color = color.blue
  end

  def open_table_button(st)
    st.frame = {centered: :horizontal, fb: 120, w: 200, h: 20}
    st.color = color.tint
    st.text = "Open table screen"
  end

  def open_metal_table_button(st)
    open_table_button st
    st.frame = {bp: 10}
    st.text = "Open metal table screen"
  end

  def open_data_table_button(st)
    open_table_button st
    st.frame = {bp: 10}
    st.text = "Open data table screen"
  end

  def open_example_controller_button(st)
    open_table_button st
    st.frame = {bp: 10}
    st.text = "Open example controller"
  end

  def grumpy_image(st)
    st.frame = {
      w: 200,
      h: 200,
      centered: :both
    }
    st.corner_radius = 100
    st.image = image.resource('grumpy_cat')
    st.remote_image = 'http://placehold.it/400x400'
  end
end
