class HelloWorldSection < UIView
  
  def on_load
    apply_style :section

    append(UIButton, :section_button).on(:touch) do
      mp "Button touched"
    end
  end
  
end
