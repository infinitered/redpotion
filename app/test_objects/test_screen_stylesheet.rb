class TestScreenStylesheet < ApplicationStylesheet

  def root_view(st)
    st.background_color = color.white
  end
  
  def test_label(st)
    st.text = 'style from sheet'
  end

end
