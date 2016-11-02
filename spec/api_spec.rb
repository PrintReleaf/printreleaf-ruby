require 'spec_helper'

describe PrintReleaf::API, "#api_key=" do
  let(:client) { Object.new.extend(PrintReleaf::API) }

  it "sets the api key" do
    client.api_key = "my-api-key"
    expect(client.api_key).to eq "my-api-key"
  end
end

describe PrintReleaf::API, "#api_key" do
  context "when the API key has been set" do
    it "returns the API key" do
      client = Object.new.extend(PrintReleaf::API)
      client.api_key = "my-api-key"
      expect(client.api_key).to eq "my-api-key"
    end
  end

  context "when the PrintReleaf::API key has not been set" do
    it "raises an error" do
      client = Object.new.extend(PrintReleaf::API)
      expect { client.api_key }.to raise_error PrintReleaf::Error, "Missing API Key."
    end
  end

  context "when the API key is nil" do
    it "raises an error" do
      client = Object.new.extend(PrintReleaf::API)
      client.api_key = nil
      expect { client.api_key }.to raise_error PrintReleaf::Error, "Missing API Key."
    end
  end

  context "when the API key is empty" do
    it "raises an error" do
      client = Object.new.extend(PrintReleaf::API)
      client.api_key = "   "
      expect { client.api_key }.to raise_error PrintReleaf::Error, "Missing API Key."
    end
  end
end

describe PrintReleaf::API, "#endpoint=" do
  let(:client) { Object.new.extend(PrintReleaf::API) }

  it "has a default" do
    expect(client.endpoint).not_to be_nil
  end

  it "sets the endpoint" do
    client.endpoint = "api.example.com"
    expect(client.endpoint).to eq "api.example.com"
  end
end

describe PrintReleaf::API, "#protocol=" do
  let(:client) { Object.new.extend(PrintReleaf::API) }

  it "has a default" do
    expect(client.protocol).not_to be_nil
  end

  it "sets the protocol" do
    client.protocol = "pants"
    expect(client.protocol).to eq "pants"
  end
end

describe PrintReleaf::API, "#get" do
  let(:client) { Object.new.extend(PrintReleaf::API) }

  before do
    client.api_key = "my-api-key"
  end

  it "returns the response data of a GET request" do
    response_data = double
    expect(client).to receive(:request).
                      with(:get, "/path/to/resource/123", {page: 5}).
                      and_return(response_data)
    expect(client.get("/path/to/resource/123", page: 5)).to eq response_data
  end
end

describe PrintReleaf::API, "#post" do
  let(:client) { Object.new.extend(PrintReleaf::API) }

  before do
    client.api_key = "my-api-key"
  end

  it "returns the response data of a POST request" do
    response_data = double
    expect(client).to receive(:request).
                      with(:post, "/path/to/resource/123", {page: 5}).
                      and_return(response_data)
    expect(client.post("/path/to/resource/123", page: 5)).to eq response_data
  end
end

describe PrintReleaf::API, "#patch" do
  let(:client) { Object.new.extend(PrintReleaf::API) }

  before do
    client.api_key = "my-api-key"
  end

  it "returns the response data of a PATCH request" do
    response_data = double
    expect(client).to receive(:request).
                      with(:patch, "/path/to/resource/123", {page: 5}).
                      and_return(response_data)
    expect(client.patch("/path/to/resource/123", page: 5)).to eq response_data
  end
end

describe PrintReleaf::API, "#delete" do
  let(:client) { Object.new.extend(PrintReleaf::API) }

  before do
    client.api_key = "my-api-key"
  end

  it "returns the response data of a DELETE request" do
    response_data = double
    expect(client).to receive(:request).
                      with(:delete, "/path/to/resource/123").
                      and_return(response_data)
    expect(client.delete("/path/to/resource/123")).to eq response_data
  end
end

describe PrintReleaf::API, "#request" do
  let(:client) { Object.new.extend(PrintReleaf::API) }

  before do
    client.api_key  = "my-api-key"
    client.endpoint = "api.example.com/v1/"
    client.protocol = "pants"
  end

  context "when it is a GET request" do
    it "performs a get with the params" do
      expect(RestClient).to receive(:get).
                            with("pants://my-api-key:@api.example.com/v1/path/to/resource/123", {params: {page: 5}, accept: :json}).
                            and_return(double(body: "{}"))
      client.request(:get, "/path/to/resource/123", page: 5)
    end
  end

  context "when it is a POST request" do
    it "performs a post with the params" do
      expect(RestClient).to receive(:post).
                            with("pants://my-api-key:@api.example.com/v1/path/to/resource/123", {page: 5}.to_json, {accept: :json, content_type: :json}).
                            and_return(double(body: "{}"))
      client.request(:post, "/path/to/resource/123", {page: 5})
    end
  end

  context "when it is a PATCH request" do
    it "performs a patch with the params" do
      expect(RestClient).to receive(:patch).
                            with("pants://my-api-key:@api.example.com/v1/path/to/resource/123", {page: 5}.to_json, {accept: :json, content_type: :json}).
                            and_return(double(body: "{}"))
      client.request(:patch, "/path/to/resource/123", {page: 5})
    end
  end

  context "when it is a DELETE request" do
    it "performs a delete on the uri" do
      expect(RestClient).to receive(:delete).
                            with("pants://my-api-key:@api.example.com/v1/path/to/resource/123").
                            and_return(double(body: "{}"))
      client.request(:delete, "/path/to/resource/123")
    end
  end

  context "when it is successful" do
    let(:raw_json)    { double(:raw_json) }
    let(:response)    { double(:response, body: raw_json) }
    let(:parsed_json) { double(:parsed_json).as_null_object }

    before do
      allow(RestClient).to receive(:get).
        with("pants://my-api-key:@api.example.com/v1/path/to/resource/123", {params: {page: 5}, accept: :json}).
        and_return(response)
    end

    context "when it can be parsed" do
      before do
        allow(JSON).to receive(:parse).
          with(raw_json).
          and_return(parsed_json)
      end

      it "returns the parsed JSON" do
        json = client.request(:get, "/path/to/resource/123", page: 5)
        expect(json).to eq parsed_json
      end
    end

    context "when it cannot be parsed" do
      before do
        allow(JSON).to receive(:parse).
          with(raw_json).
          and_raise(JSON::ParserError)
      end

      it "raises ResponseError" do
        expect {
          client.request(:get, "/path/to/resource/123", page: 5)
        }.to raise_error PrintReleaf::ResponseError, "Unable to parse response. Please try again. (JSON::ParserError)"
      end
    end
  end

  context "when it is not successful" do
    context "when it is a known http status code" do
      it "raises an error with the appropriate message" do
        response = double(:response, code: 400, body: '{"code":400,"error":"Invalid or missing request parameters."}')
        allow(RestClient).to receive(:get).and_raise(RestClient::ExceptionWithResponse.new(response))
        expect { client.request(:get, "/path/to/resource/123") }.to raise_error PrintReleaf::BadRequest, "Invalid or missing request parameters. (code=400)"

        response = double(:response, code: 401, body: '{"code":401,"error":"Invalid API key."}')
        allow(RestClient).to receive(:get).and_raise(RestClient::ExceptionWithResponse.new(response))
        expect { client.request(:get, "/path/to/resource/123") }.to raise_error PrintReleaf::Unauthorized, "Invalid API key. (code=401)"

        response = double(:response, code: 403, body: '{"code":403,"error":"API keys were provided but the requested action is not authorized."}')
        allow(RestClient).to receive(:get).and_raise(RestClient::ExceptionWithResponse.new(response))
        expect { client.request(:get, "/path/to/resource/123") }.to raise_error PrintReleaf::Forbidden, "API keys were provided but the requested action is not authorized. (code=403)"

        response = double(:response, code: 404, body: '{"code":404,"error":"Not Found."}')
        allow(RestClient).to receive(:get).and_raise(RestClient::ExceptionWithResponse.new(response))
        expect { client.request(:get, "/path/to/resource/123") }.to raise_error PrintReleaf::NotFound, "Not Found. (code=404)"

        response = double(:response, code: 429, body: '{"code":429,"error":"Rate limit exceeded."}')
        allow(RestClient).to receive(:get).and_raise(RestClient::ExceptionWithResponse.new(response))
        expect { client.request(:get, "/path/to/resource/123") }.to raise_error PrintReleaf::RateLimitExceeded, "Rate limit exceeded. (code=429)"

        response = double(:response, code: 500, body: '{"code":500,"error":"Something went wrong. Please try again."}')
        allow(RestClient).to receive(:get).and_raise(RestClient::ExceptionWithResponse.new(response))
        expect { client.request(:get, "/path/to/resource/123") }.to raise_error PrintReleaf::ServerError, "Something went wrong. Please try again. (code=500)"
      end
    end

    context "when it is an unknown http status code" do
      it "raises RequestError with a generic message" do
        allow(RestClient).to receive(:get).and_raise(RestClient::ExceptionWithResponse)
        expect {
          client.request(:get, "/path/to/resource/123")
        }.to raise_error PrintReleaf::RequestError, "Something went wrong with the request. Please try again. (RestClient::ExceptionWithResponse)"
      end
    end

    context "when a network exception is raised" do
      before do
        stub_const("PrintReleaf::API::MAX_RETRY_COUNT", 3)
        stub_const("PrintReleaf::API::RETRY_DELAY_BASE", 0) # Don't sleep between retries
      end

      it "raises NetworkError with a network error message" do
        allow(RestClient).to receive(:get).and_raise(SocketError)
        expect {
          client.request(:get, "/path/to/resource/123")
        }.to raise_error PrintReleaf::NetworkError, "Unexpected error communicating when trying to connect to PrintReleaf. Request was retried 3 times. (SocketError)"
      end

      it "raises NetworkError with a network error message" do
        allow(RestClient).to receive(:get).and_raise(Errno::ECONNREFUSED)
        expect {
          client.request(:get, "/path/to/resource/123")
        }.to raise_error PrintReleaf::NetworkError, "Unexpected error communicating when trying to connect to PrintReleaf. Request was retried 3 times. (Errno::ECONNREFUSED)"
      end
    end

    context "when an unknown exception is raised" do
      it "does not rescue it" do
        allow(RestClient).to receive(:get).and_raise(StandardError)
        expect {
          client.request(:get, "/path/to/resource/123")
        }.to raise_error StandardError
      end
    end
  end
end

