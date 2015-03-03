class ExampleControllerStylesheet < ApplicationStylesheet

  def setup
    # Add stylesheet specific setup stuff here.
    # Add application specific setup stuff in application_stylesheet.rb
  end

  def root_view(st)
    st.background_color = color.purple
  end

  # hello_world(st)
  # Defined in ApplicationStylesheet

end
