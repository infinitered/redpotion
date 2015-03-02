module RubyMotionQuery
  module Stylers

    class UIImageViewStyler < UIViewStyler

      def remote_image=(value)
        if @view.respond_to?("setImageWithURL:placeholder:")
          value = NSURL.URLWithString(value) unless value.is_a?(NSURL)
          @view.setImageWithURL(value, placeholder:@view.image)
        else
          puts "\n[RedPotion ERROR]  tried to set remote_image without JMImageCache cocoapod. Please add this to your Rakefile: \n\napp.pods do\n  pod \"JMImageCache\"\nend\n"
        end
      end

      # This is the same functionality as image=
      def placeholder_image=(value)
        @view.image = value
      end
    end
  end
end
