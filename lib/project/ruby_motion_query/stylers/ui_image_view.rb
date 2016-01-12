module RubyMotionQuery
  module Stylers

    class UIImageViewStyler < UIViewStyler

      def remote_image=(value)
        @view.remote_image = value
      end

      # This is the same functionality as image=
      def placeholder_image=(value)
        @view.image = value
      end
      
    end
  end
end
