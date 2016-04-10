class MetalTableScreenStylesheet < ApplicationStylesheet
  
  def setup
  end

  def root_view(st)
    st.background_color = color.gray
  end

  def cell_height
    80 # Anything visual should be in the stylesheet
  end

  def cell(st)
    st.background_color = color.yellow
  end

  def cell_name(st)
    st.frame = {t: 5, w: 200, h: 20, centered: :horizontal}
    st.background_color = color.white
    st.color = color.blue
  end
  
end
