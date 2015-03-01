def load_image(path)
  NSData.dataWithContentsOfFile(NSBundle.mainBundle.pathForResource(path, ofType:'jpeg'))
end
