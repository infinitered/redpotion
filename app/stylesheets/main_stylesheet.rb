class MainStylesheet < ApplicationStylesheet

  def root_view(st)
    st.background_color = color.white
  end

  def hello_world(st)
    st.frame = {w: 200, h: 30, centered: :both}
    st.color = color.red
    st.font = font.large
    st.text = "Hello world"
  end
end
