RedPotion uses the following for networking:

* AFNetworking pod
* AFMotion gem
* JMImageCache

-------

## Remote images

You can set `remote_image` to a URL string or an instance of `NSURL` and it will automatically fetch the image and set the image (with caching) using the power of [JMImageCache](https://github.com/jakemarsh/JMImageCache).

You should always use `remote_image` for any image you download, it will cache it to memory and out to disk when it's appropriate. It does it async and is performant, even for a large table of images.

```ruby
class MyStylesheet < ApplicationStylesheet
  def my_ui_image_view(st)
    # placeholder_image= is just an alias to image=
    # Set the placeholder image you want from your resources directory
    st.placeholder_image = image.resource("my_placeholder")
    # Set the remote URL. It will be applied to the UIImageView
    # when downloaded or retrieved from the local cache.
    st.remote_image = "http://www.rubymotion.com/img/rubymotion-logo.png"
    # or st.remote_image = NSURL.urlWithString(...)
  end
end
```

To assign a remote image to a UIImageView:

```ruby
your_ui_image_view.remote_image = "http://bit.ly/18iMhwc"
```

-------

## Get HTML or JSON directly


```ruby
AFMotion::HTTP.get("http://google.com") do |result|
  mp result.body
end

AFMotion::JSON.get("http://jsonip.com") do |result|
  mp result.object["ip"]
end
```

-------

## Setup a session client to reuse (best practice)

```ruby
@client = AFMotion::SessionClient.build("https://alpha-api.app.net/") do
  session_configuration :default

  header "Accept", "application/json"

  response_serializer :json
end
```

Then use it:

```ruby
@client.get("stream/0/posts/stream/global") do |result|
  # result.operation is the AFURLConnectionOperation instance
  mp result.operation.inspect
  mp result.status_code

  if result.success?
    # result.object depends on the type of operation.
    # For JSON and PLIST, this is usually a Hash.
    # For XML, this is an NSXMLParser
    # For HTTP, this is an NSURLResponse
    # For Image, this is a UIImage
    p result.object

  elsif result.failure?
    # result.error is an NSError
    mp result.error.localizedDescription
  end
end
```

The client support methods of the form `Client#get/post/put/patch/delete(url, request_parameters)`. The `request_parameters` is a hash containing your parameters to attach as the request body or URL parameters, depending on request type. For example:

```ruby
@client.get("users", id: 1) do |result|
  ...
end

@client.post("users", name: "@clayallsopp", library: "AFMotion") do |result|
  ...
end
```

#### Multipart Requests

The session supports multipart form requests (i.e. for image uploading) - simply use `multipart_post` and it'll convert your parameters into properly encoded multipart data. For all other types of request data, use the `form_data` object passed to your callback:

```ruby
# an instance of UIImage
image = my_function.get_image
data = UIImagePNGRepresentation(image)

@client.multipart_post("avatars") do |result, form_data|
  if form_data
    # Called before request runs
    # see: https://github.com/AFNetworking/AFNetworking/wiki/AFNetworking-FAQ
    form_data.appendPartWithFileData(data, name: "avatar", fileName:"avatar.png", mimeType: "image/png")
  elsif result.success?
    ...
  else
    ...
  end
end
```

This is an instance of [`AFMultipartFormData`](http://cocoadocs.org/docsets/AFNetworking/2.0.0/Protocols/AFMultipartFormData.html).

If you want to track upload progress, you can add a third callback argument which returns the upload percentage between 0.0 and 1.0:

```ruby
@client.multipart_post("avatars") do |result, form_data, progress|
  if form_data
    # Called before request runs
    # see: https://github.com/AFNetworking/AFNetworking/wiki/AFNetworking-FAQ
    form_data.appendPartWithFileData(data, name: "avatar", fileName:"avatar.png", mimeType: "image/png")
  elsif progress
    # 0.0 < progress < 1.0
    my_widget.update_progress(progress)
  else
  ...
end
```

#### Headers

You can set default HTTP headers using `@client.headers`, which is sort of like a `Hash`:

```ruby
@client.headers["Accept"]
#=> "application/json"

@client.headers["Accept"] = "something_else"
#=> "application/something_else"

@client.headers.delete "Accept"
#=> "application/something_else"
```

#### Client Building DSL

The session client DSLs allows the following properties:

- `header(header, value)`
- `authorization(username: ___, password: ____)` for HTTP Basic auth, or `authorization(token: ____)` for Token based auth.
- `request_serializer(serializer)`. Allows you to set an [`AFURLRequestSerialization`](http://cocoadocs.org/docsets/AFNetworking/2.0.0/Protocols/AFURLRequestSerialization.html) for all your client's requests, which determines how data is encoded on the way to the server. So if your API is always going to be JSON, you should set `operation(:json)`. Accepts `:json` and `:plist`, or any instance of `AFURLRequestSerialization` and must be called before calling `header` or `authorization` or else the [headers will not be applied](https://github.com/clayallsopp/afmotion/issues/78).
- `response_serializer(serializer)`. Allows you to set an [`AFURLResponseSerialization`](http://cocoadocs.org/docsets/AFNetworking/2.0.0/Protocols/AFURLResponseSerialization.html), which determines how data is decoded once the server respnds. Accepts `:json`, `:xml`, `:plist`, `:image`, `:http`, or any instance of `AFURLResponseSerialization`.
- `session_configuration(session_configuration, identifier = nil)`. Allows you to set the [`NSURLSessionConfiguration`](https://developer.apple.com/library/ios/documentation/Foundation/Reference/NSURLSessionConfiguration_class/Reference/Reference.html#//apple_ref/occ/cl/NSURLSessionConfiguration). Accepts `:default`, `:ephemeral`, `:background` (with the `identifier` as a String), or an instance of `NSURLSessionConfiguration`.

You can also configure your client by passing it as a block argument:

```ruby
@client = AFMotion::SessionClient.build("https://alpha-api.app.net/") do |client|
  client.session_configuration :default

  client.header "Accept", @custom_header
end
```

See all of AFMotion's [docs here](https://github.com/clayallsopp/afmotion).
