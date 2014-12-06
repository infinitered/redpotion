module ProMotion
  module ScreenModule
    def view_did_load
      if self.class.rmq_style_sheet_class
        self.rmq.stylesheet = self.class.rmq_style_sheet_class
        self.view.rmq.apply_style :root_view
      end

      self.on_load
    end

    module RedPotionClassMethods
      def stylesheet(style_sheet_class)
        @rmq_style_sheet_class = style_sheet_class
      end

      def rmq_style_sheet_class
        @rmq_style_sheet_class
      end
    end

    def self.included(base)
      base.extend(ClassMethods)
      base.extend(TabClassMethods) # TODO: Is there a better way?
      base.extend(RedPotionClassMethods)
    end

  end

end
