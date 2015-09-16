class UIImageView

  def remote_image=(value)
    if !!defined?(SDWebImageManager)
      @remote_image_operations ||= {}

      # Cancel the previous remote operation if it exists
      operation = @remote_image_operations[("%p" % self)]
      if operation && operation.respond_to?(:cancel)
        operation.cancel
        @remote_image_operations[("%p" % self)] = nil
      end

      value = NSURL.URLWithString(value) unless value.is_a?(NSURL)
      @remote_image_operations[("%p" % self)] = SDWebImageManager.sharedManager.downloadWithURL(value,
        options:SDWebImageRefreshCached,
        progress:nil,
        completed: -> image, error, cacheType, finished {
          Dispatch::Queue.main.async do
            self.image = image
          end unless image.nil?
      })
    else
      puts "\n[RedPotion ERROR]  tried to set remote_image without SDWebImage cocoapod. Please add this to your Rakefile: \n\napp.pods do\n  pod \"SDWebImage\"\nend\n"
    end
  end

end
