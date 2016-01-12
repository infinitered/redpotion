class TasksScreenStylesheet < ApplicationStylesheet

  def root_view(st)
    st.background_color = color.gray
  end

  def cell(st)
    st.background_color = color.green
  end

  def cell_title(st)
    st.frame = {t: 5, w: 200, h: 20, centered: :horizontal}
    st.background_color = color.white
    st.color = color.red
  end
  
end
