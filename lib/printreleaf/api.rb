module PrintReleaf
  module API
    extend self

    ENDPOINT = "api.printreleaf.com/v1/"
    PROTOCOL = "https"
    MAX_RETRY_COUNT = 2
    NETWORK_EXCEPTIONS = [
      SocketError,
      Errno::ECONNREFUSED,
      Errno::ECONNRESET,
      Errno::ETIMEDOUT,
      RestClient::RequestTimeout
    ]

    attr_writer :api_key
    attr_writer :endpoint
    attr_writer :protocol
    attr_accessor :logger

    def api_key
      if @api_key.nil? or @api_key.strip.to_s.empty?
        raise Error, "Missing API Key."
      else
        return @api_key
      end
    end

    def endpoint
      @endpoint || ENDPOINT
    end

    def protocol
      @protocol || PROTOCOL
    end

    def get(uri="/", params={})
      request :get, uri, params
    end

    def post(uri, data={})
      request :post, uri, data
    end

    def patch(uri, data={})
      request :patch, uri, data
    end

    def delete(uri)
      request :delete, uri
    end

    def request(verb, uri, params={})
      perform_request do
        uri = Util.join_uri(endpoint, uri)
        url = "#{protocol}://#{api_key}:@#{uri}"

        unless logger.nil?
          logger.info "[PrintReleaf] #{verb.upcase} #{uri}"
        end

        response = case verb
        when :get;    RestClient.get url, params: params, accept: :json
        when :post;   RestClient.post url, params.to_json, accept: :json, content_type: :json
        when :patch;  RestClient.patch url, params.to_json, accept: :json, content_type: :json
        when :delete; RestClient.delete url
        end

        JSON.parse(response.body)
      end
    end

    private

    def perform_request(&block)
      retry_count = 0
      begin
        yield
      rescue => e
        if should_retry?(e, retry_count)
          retry_count += 1
          retry
        else
          handle_error(e, retry_count)
        end
      end
    end

    def handle_error(e, retry_count)
      case e
      when RestClient::ExceptionWithResponse
        if e.response
          handle_api_error(e, retry_count)
        else
          handle_restclient_error(e, retry_count)
        end
      when JSON::ParserError
        handle_json_error(e, retry_count)
      when *NETWORK_EXCEPTIONS
        handle_network_error(e, retry_count)
      else
        raise
      end
    end

    def handle_api_error(e, retry_count = 0)
      # We likely got a http status code outside the 200-399 range.
      # If this is a GET or DELETE request, it is likely the resource is not owned by the client.
      # If this is a POST, PUT, or PATCH, the data might be invalid.
      message = JSON.parse(e.response.body)["message"]
      raise Error, message
    end

    def handle_json_error(e, retry_count = 0)
      # We received the data fine, but we're unable to parse it.
      # Re-raise a generic error.
      message = "Something went wrong parsing the response. Please try again."
      message += " Request was retried #{retry_count} times." if retry_count > 0
      message += " (#{e.class.name})"
      raise Error, message
    end

    def handle_network_error(e, retry_count = 0)
      message = "Unexpected error communicating when trying to connect to PrintReleaf."
      message += " Request was retried #{retry_count} times." if retry_count > 0
      message += " (#{e.class.name})"
      raise Error, message
    end

    def handle_restclient_error(e, retry_count = 0)
      message = "Something went wrong with the request. Please try again."
      message += " Request was retried #{retry_count} times." if retry_count > 0
      message += " (#{e.class.name})"
      raise Error, message
    end

    def should_retry?(e, retry_count = 0)
      NETWORK_EXCEPTIONS.include?(e.class) && retry_count < MAX_RETRY_COUNT
    end
  end
end

