# To style this view include its stylesheet at the top of each controller's
# stylesheet that is going to use it:
#   class SomeStylesheet < ApplicationStylesheet
#     include <%= @name_camel_case %>Stylesheet

# Another option is to use your controller's stylesheet to style this view. This
# works well if only one controller uses it. If you do that, delete the
# view's stylesheet with:
#   rm app/stylesheets/<%= @name %>_stylesheet.rb

module <%= @name_camel_case %>Stylesheet

  def <%= @name %>_height
    40
  end

  def <%= @name %>(st)
    st.frame = {l: 5, t: 100, w: 80, h: <%= @name %>_height}
    st.background_color = color.light_gray

    # Style overall view here
  end

  def <%= @name %>_title(st)
    st.frame = {l: 10, fr: 0, centered: :vertical, h: 20}
    st.font = font.medium
    st.color = color.black
  end

end
