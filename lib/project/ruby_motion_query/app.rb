module RubyMotionQuery
  class App
    class << self
      def current_screen(root_view_controller = nil)
        current_view_controller root_view_controller
      end

      def data(*args) # Do not alias this
        CDQ.cdq(*args)
      end

      def net
        RedPotionNet
      end

      def reset_image_cache!
        if !!defined?(SDWebImageManager)
          image_cache = SDImageCache.sharedImageCache
          image_cache.clearMemory
          image_cache.clearDisk
        else
          puts "\n[RedPotion ERROR]  tried to reset image cache without SDWebImage cocoapod. Please add this to your Rakefile: \n\napp.pods do\n  pod \"SDWebImage\"\nend\n"
        end
      end
    end
  end
end
