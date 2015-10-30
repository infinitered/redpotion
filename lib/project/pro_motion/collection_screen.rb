module ProMotion
  class CollectionScreen

    def set_stylesheet
      super.tap do
        if self.class.rmq_style_sheet_class
          self.collection_view.rmq.apply_style(:collection_view) if self.rmq.stylesheet.respond_to?(:collection_view)
        end
      end
    end

  end
end
