class ExampleControllerStylesheet < ApplicationStylesheet

  def setup
    # Add stylesheet specific setup stuff here.
    # Add application specific setup stuff in application_stylesheet.rb
  end

  def root_view(st)
    st.background_color = color.purple
  end

 def hello_world(st)
    st.frame = {w: 200, h: 30, centered: :both}
    st.color = color.black
    st.font = font.large
    st.text = "Hello world"
  end


end
