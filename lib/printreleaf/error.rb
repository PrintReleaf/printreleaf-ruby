module PrintReleaf
  class Error < StandardError
  end

  class RequestError < Error
  end

  class BadRequest < Error
  end

  class Unauthorized < Error
  end

  class Forbidden < Error
  end

  class NotFound < Error
  end

  class RateLimitExceeded < Error
  end

  class ServerError < Error
  end

  class NetworkError < Error
  end

  class ResponseError < Error
  end
end

