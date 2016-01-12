class <%= @name_camel_case %>ScreenStylesheet < ApplicationStylesheet

  def setup
    # Add stylesheet specific setup stuff here.
    # Add application specific setup stuff in application_stylesheet.rb
  end

  def root_view(st)
    st.background_color = color.gray
  end

  def cell(st)
    # Style overall cell here
    st.background_color = color.random
  end

  def cell_height
    80
  end

  def cell_name(st)
    st.frame = {left: 5, top: 5, from_right: 10, from_bottom: 5}
    st.color = color.black
  end
  
end
