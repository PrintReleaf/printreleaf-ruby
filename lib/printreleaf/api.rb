module PrintReleaf
  module API
    extend self

    ENDPOINT = "api.printreleaf.com/v1/"
    PROTOCOL = "https"
    USER_AGENT = "PrintReleaf Ruby/#{PrintReleaf::VERSION}"
    MAX_RETRY_COUNT = 2
    RETRY_DELAY_BASE = 1.5 # Base for exponential delay

    NETWORK_EXCEPTIONS = [
      SocketError,
      Errno::ECONNREFUSED,
      Errno::ECONNRESET,
      Errno::ETIMEDOUT,
      RestClient::RequestTimeout
    ]

    API_EXCEPTIONS = {
      400 => BadRequest,
      401 => Unauthorized,
      403 => Forbidden,
      404 => NotFound,
      429 => RateLimitExceeded,
      500 => ServerError
    }

    attr_writer :api_key
    attr_writer :endpoint
    attr_writer :protocol
    attr_writer :user_agent
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

    def user_agent
      @user_agent || USER_AGENT
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
        url = "#{protocol}://#{uri}"

        request_params = {
          method: verb,
          url: url,
          headers: {
            accept: :json,
            :Authorization => "Bearer #{api_key}",
            :user_agent => user_agent
          }
        }

        if verb == :get || verb == :delete
          request_params[:headers][:params] = params unless params.empty?
        else
          request_params[:payload] = params.to_json
          request_params[:headers][:content_type] = :json
        end

        unless logger.nil?
          logger.info "[PrintReleaf] #{verb.upcase} #{uri}"
        end

        response = RestClient::Request.execute(request_params)

        JSON.parse(response.body)
      end
    end

    private

    def perform_request
      retry_count = 0
      begin
        yield
      rescue => e
        if should_retry?(e, retry_count)
          retry_count += 1
          sleep retry_delay(retry_count)
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

    def handle_api_error(e, retry_count=0)
      # We likely got an http status code outside the 200-399 range.
      # If this is a GET or DELETE request, it is likely the resource is not owned by the client.
      # If this is a POST, PUT, or PATCH, the data might be invalid.
      code = e.response.code
      message = e.response ? JSON.parse(e.response.body)["error"] : "Something went wrong. Please try again."
      message += " (code=#{code})"
      message += " Request was retried #{retry_count} times." if retry_count > 0
      exception = API_EXCEPTIONS[e.response.code] || Error
      raise exception, message
    end

    def handle_json_error(e, retry_count=0)
      # We received the data fine, but we're unable to parse it.
      # Re-raise a generic error.
      message = "Unable to parse response. Please try again."
      message += " Request was retried #{retry_count} times." if retry_count > 0
      message += " (#{e.class.name})"
      raise ResponseError, message
    end

    def handle_network_error(e, retry_count=0)
      message = "Unexpected error communicating when trying to connect to PrintReleaf."
      message += " Request was retried #{retry_count} times." if retry_count > 0
      message += " (#{e.class.name})"
      raise NetworkError, message
    end

    def handle_restclient_error(e, retry_count=0)
      message = "Something went wrong with the request. Please try again."
      message += " Request was retried #{retry_count} times." if retry_count > 0
      message += " (#{e.class.name})"
      raise RequestError, message
    end

    def should_retry?(e, retry_count=0)
      NETWORK_EXCEPTIONS.include?(e.class) && retry_count < MAX_RETRY_COUNT
    end

    def retry_delay(retry_count=0)
      RETRY_DELAY_BASE ** retry_count
    end
  end
end

