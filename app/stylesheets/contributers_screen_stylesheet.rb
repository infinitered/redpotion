class ContributerScreenStylesheet < ApplicationStylesheet
  def root_view(st)
    st.background_color = color.white
  end

  def cell(st)
    st.background_color = color.white
  end

  def cell_title(st)
    st.frame = {t: 5, w: device_width / 2, h: 20, l: 5}
    st.background_color = color.white
    st.color = color.black
  end

  def github_button(st)
    st.text = "View profile"
    st.frame = {t: 5, w: device_width / 2, h: 20, fr: 5}
    st.color = color.orange
  end
end
