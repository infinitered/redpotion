# result that is returned has these attributes:
#   response
#   object
#   body
#   status_code
#   headers
#   not_modified?
#   success?
#   failure?
#
# @example
#   # Create a session and do a single HTML get. It's better
#   # to use the shared session below.
#   app.net.get("http://google.com") do |response|
#     mp response.object # <- HTML
#   end
#
#   # To initialize the shared session, which is best to use
#   # rather than the one-off above, do this. Once this
#   # is done, all your gets, posts, puts, etc will use this
#   # share session
#   app.net.build_shared("http://baseurl.com") do |shared|
#     # Leave blank for string, if you don't set the serializer
#     # to be json, you can still use get_json
#     header "Accept", "application/json"
#     response_serializer :json
#   end
#
#   # For shared, use relative paths
#   app.net.get("foo.html") do |response|
#     mp response.object # <- returns type you set in shared.serializer
#   end
#
#   # Post
#   app.net.post("foo/bar", your_params_hash) do |response|
#     mp response.object # <- returns type you set in shared.serializer
#   end
#
#   # If you have built a shared session, but want to use another
#   # session, do this:
#   app.net.get("foo.html", session: app.net.single_use_session) do |response|
#     mp response.object # <- returns type you set in shared.serializer
#   end
#
#   # Get json:
#   url = "http://openweathermap.org/data/2.1/find/name?q=san%20francisco"
#   app.net.get_json(url) do |request|
#     # request.object is a hash, parsed from the json
#     temp_kelvin = request.object["list"].first["main"]["temp"]
#   end
#
#   # Log responses
#   app.net.debug = true
class RedPotionNet
  class << self
    attr_accessor :debug

    def session_client
      @_session_client ||= AFMotion::SessionClient
    end

    def session(force_json = false)
      # TODO use AFMotions's single use methods
      session_client.shared ? session_client.shared : single_use_session(force_json)
    end

    def is_shared?
      !session_client.shared.is_nil?
    end

    def build_shared(url, &block)
      AFMotion::SessionClient.build(url) do |client|
        client.session_configuration :default
        block.call
      end
    end

    def get(url, params={}, opts={}, &block)
      raise "[RedPotion error] You must provide a block when using app.net.get" unless block
      ses = opts.delete(:session) || self.session
      ses.get(url, params, opts, &block)
    end

    def get_json(url, params={}, opts={}, &block)
      raise "[RedPotion error] You must provide a block when using app.net.get_json" unless block
      ses = opts.delete(:session) || self.session
      opts[:serializer] = :json
      #AFMotion::JSON.get
      ses.get(url, params, opts, &block)
    end

    def post(url, params, opts={}, &block)
      raise "[RedPotion error] You must provide a block when using app.net.post" unless block
      ses = opts.delete(:session) || self.session
      ses.post(url, params, opts, &block)
    end

    def put(url, params, opts={}, &block)
      raise "[RedPotion error] You must provide a block when using app.net.put" unless block
      ses = opts.delete(:session) || self.session
      ses.put(url, params, opts, &block)
    end

    def delete(url, params, opts={}, &block)
      raise "[RedPotion error] You must provide a block when using app.net.delete" unless block
      ses = opts.delete(:session) || self.session
      ses.delete(url, params, opts, &block)
    end

    def single_use_session(use_json = false)
      @client = AFMotion::Client.build("") do
        if use_json
          header "Accept", "application/json"
          response_serializer :json
        end
      end
    end

  end
end


__END__

    def log_response(respose)
      header_string = if (h = headers)
        h.map{|k,v| "  #{k} = #{v}"}.join("\n")
      else
        "none"
      end

      params_string = if @request_params
        @request_params.map{|k,v| "  #{k} = #{v}"}.join("\n")
      else
        "none"
      end

      %(

Request -------------------------

URL: #{@request_url}
Method: #{method_description}
Params:
#{params_string}

Response -------------------------

Status code: #{status_code}
Not modified?: #{not_modified?}
Success: #{success?}

Error: #{error.toString if error}

Headers:
#{header_string}

Body:
#{body}
-----------------------------------

)
    end


  end
end
