module RubyMotionQuery
  module Stylers

    class UIImageViewStyler < UIViewStyler

      alias :"placeholder_image=" :"image="
      def remote_image=(value)
        if @view.respond_to?("setImageWithURL:placeholder:")
          value = NSURL.URLWithString(value) unless value.is_a?(NSURL)
          @view.setImageWithURL(value, placeholder:@view.image)
        else
          puts "\n[RMQ ERROR]  tried to set remote_image without JMImageCache cocoapod. Please add this to your Rakefile: \n\napp.pods do\n  pod \"JMImageCache\"\nend\n"
        end
      end
    end
  end
end
