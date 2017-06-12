class UIImageView

  def remote_image=(args)
    url = args.respond_to?(:fetch) ? args.fetch(:url) : args
    on_load = args.respond_to?(:fetch) ? args.fetch(:on_load, -> {}) : -> {}
    load_remote_image(url, on_load)
  end

  private

  def load_remote_image(url, callback = nil)
    if defined?(SDWebImageManager)
      @remote_image_operations ||= {}
      # Cancel the previous remote operation if it exists
      operation = @remote_image_operations[("%p" % self)]
      if operation && operation.respond_to?(:cancel)
        operation.cancel
        @remote_image_operations[("%p" % self)] = nil
      end
      url = NSURL.URLWithString(url) unless url.is_a?(NSURL)
      @remote_image_operations[("%p" % self)] = load_remote_image_using_sdwebimage(url, callback)
    else
      puts "\n[RedPotion ERROR]  tried to set remote_image without SDWebImage CocoaPod. Please add this to your Rakefile: \n\napp.pods do\n  pod \"SDWebImage\"\nend\n"
    end
  end

  def load_remote_image_using_sdwebimage(url, callback = nil)
    manager = SDWebImageManager.sharedManager
    if manager.respond_to?('downloadWithURL:options:progress:completed')
      # Support for SDWebImage v3.x
      manager.downloadWithURL(url,
        options: SDWebImageRefreshCached,
        progress: nil,
        completed: -> image, error, cacheType, finished {
          Dispatch::Queue.main.async do
            self.image = image
            callback.call if callback
          end unless image.nil?
        }
      )
    else
      # Support for SDWebImage v4.x
      manager.loadImageWithURL(url,
        options: SDWebImageRefreshCached,
        progress: nil,
        completed: -> image, imageData, error, cacheType, finished, imageURL {
          Dispatch::Queue.main.async do
            self.image = image
            callback.call if callback
          end unless image.nil?
        }
      )
    end
  end

end
