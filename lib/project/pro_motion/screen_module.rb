module ProMotion
  module ScreenModule
    def view_did_load
      if self.class.rmq_style_sheet_class
        self.rmq.stylesheet = self.class.rmq_style_sheet_class
        self.view.rmq.apply_style :root_view
      end

      self.on_load
    end
  end
end
