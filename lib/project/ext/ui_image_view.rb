class UIImageView

  def remote_image=(url)
    load_remote_image(url)
  end

  def remote_image(args)
    load_remote_image(args.fetch(:url), args.fetch(:did_load))
  end

  private

  def load_remote_image(url, did_load = -> {})
    if !!defined?(SDWebImageManager)
      @remote_image_operations ||= {}

      # Cancel the previous remote operation if it exists
      operation = @remote_image_operations[("%p" % self)]
      if operation && operation.respond_to?(:cancel)
        operation.cancel
        @remote_image_operations[("%p" % self)] = nil
      end

      value = NSURL.URLWithString(url) unless url.is_a?(NSURL)
      @remote_image_operations[("%p" % self)] = SDWebImageManager.sharedManager.downloadWithURL(value,
        options:SDWebImageRefreshCached,
        progress:nil,
        completed: -> image, error, cacheType, finished {
          Dispatch::Queue.main.async do
            self.image = image
            did_load.call
          end unless image.nil?
      })
    else
      puts "\n[RedPotion ERROR]  tried to set remote_image without SDWebImage cocoapod. Please add this to your Rakefile: \n\napp.pods do\n  pod \"SDWebImage\"\nend\n"
    end
  end

end
