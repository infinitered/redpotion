def load_image(path, type = "jpeg")
  NSData.dataWithContentsOfFile(NSBundle.mainBundle.pathForResource(path, ofType:type))
end
