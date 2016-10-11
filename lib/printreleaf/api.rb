module PrintReleaf
  module API
    extend self

    ENDPOINT = "api.printreleaf.com/v1/"

    attr_writer :api_key
    attr_accessor :logger

    def api_key
      if @api_key.nil? or @api_key.strip.to_s.empty?
        raise Error, "Missing API Key."
      else
        return @api_key
      end
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
        uri = Util.join_uri(ENDPOINT, uri)
        url = "https://#{api_key}:@#{uri}"

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
      begin
        yield

        # At this point, some exception has been raised either
        # during the request or parsing the response.
        #
        # We determine the type of error, and re-raise
        # our own error from the message in the response body.
      rescue RestClient::Exception => e
        # We likely got a http status code outside the 200-399 range.
        # If this is a GET or DELETE request, it is likely the resource is not owned by the client.
        # If this is a POST, PUT, or PATCH, the data might be invalid.

        # Handle 400, 401, 403, 404, 429 errors.
        # 400 Bad Request       - Invalid or missing request parameters.
        # 401 Unauthorized      - Invalid API key.
        # 403 Forbidden         - API keys were provided but the requested action is not authorized.
        # 404 Not Found         - The requested item doesn't exist or the client doesn't own it.
        # 429 Too Many Requests - Rate limit exceeded.
        if [400, 401, 403, 404, 429].include?(e.http_code)
          raise Error, JSON.parse(e.http_body)["message"]
        end

        # Handle any other http error (i.e. 5xx+), or other RestClient exceptions.
        # Re-raise a generic error.
        raise Error, "Something went wrong with the request. Please try again."
      rescue JSON::ParserError => e
        # We received the data fine, but we're unable to parse it.
        # Re-raise a generic error.
        raise Error, "Something went wrong parsing the response. Please try again."
      rescue StandardError => e
        # Something else went wrong.
        # Re-raise a generic error.
        raise Error, "Something went wrong. Please try again."
      end
    end
  end
end

