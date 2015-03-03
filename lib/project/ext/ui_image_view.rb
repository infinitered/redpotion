class UIImageView

  def remote_image=(value)
    if self.respond_to?("setImageWithURL:placeholder:")
      value = NSURL.URLWithString(value) unless value.is_a?(NSURL)
      self.setImageWithURL(value, placeholder:self.image)
    else
      puts "\n[RedPotion ERROR]  tried to set remote_image without JMImageCache cocoapod. Please add this to your Rakefile: \n\napp.pods do\n  pod \"JMImageCache\"\nend\n"
    end
  end

end
