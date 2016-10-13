require 'spec_helper'

describe PrintReleaf::Certificate do
  it_behaves_like "Resource"
end

describe PrintReleaf::Certificate, ".uri" do
  it "returns the base resource uri" do
    expect(PrintReleaf::Certificate.uri).to eq "/certificates"
  end
end

describe PrintReleaf::Certificate, "properties" do
  let(:json) do
    JSON.parse <<-JSON
      {
        "id": "ae630937-e15b-4da5-98de-bb68eefe2a12",
        "account_id": "971d10ac-a912-42c0-aa41-f55adc7b6755",
        "period_start": "2016-09-01T06:00:00Z",
        "period_end": "2016-10-01T05:59:59Z",
        "pages": 2469134,
        "trees": 296.31,
        "project_id": "5d3b468f-c0a3-4e7c-bed4-2dcce9d3f0f9",
        "project": {
          "id": "5d3b468f-c0a3-4e7c-bed4-2dcce9d3f0f9",
          "name": "Madagascar",
          "status": "active",
          "forest_latitude": -15.735844444444444,
          "forest_longitude": 46.35879166666667,
          "content_logo": "http://s3.amazonaws.com/projects/madagascar/logo.jpg",
          "content_masthead": "http://s3.amazonaws.com/projects/madagascar/masthead.jpg",
          "content_introduction": "Madagascar, due to its isolation from the rest of the world...",
          "content_body_html": "<h1>Madagascar is one of the most threatened ecosystems on the planet...",
          "content_images": [
            "http://s3.amazonaws.com/projects/madagascar/1.jpg",
            "http://s3.amazonaws.com/projects/madagascar/2.jpg",
            "http://s3.amazonaws.com/projects/madagascar/3.jpg"
          ]
        }
      }
    JSON
  end

  it "gives access to JSON properties" do
    certificate = PrintReleaf::Certificate.new(json)
    expect(certificate.id).to eq "ae630937-e15b-4da5-98de-bb68eefe2a12"
    expect(certificate.account_id).to eq "971d10ac-a912-42c0-aa41-f55adc7b6755"
    expect(certificate.period_start).to eq DateTime.parse("2016-09-01T06:00:00Z")
    expect(certificate.period_end).to eq DateTime.parse("2016-10-01T05:59:59Z")
    expect(certificate.pages).to eq 2469134
    expect(certificate.trees).to eq 296.31
    expect(certificate.project_id).to eq "5d3b468f-c0a3-4e7c-bed4-2dcce9d3f0f9"
    expect(certificate.project).to be_a PrintReleaf::Project
  end
end

describe PrintReleaf::Certificate, "#account" do
  it "returns the certificate's account" do
    account = double
    allow(PrintReleaf::Account).to receive(:find).with("123").and_return(account)
    certificate = PrintReleaf::Certificate.new(account_id: "123")
    expect(certificate.account).to eq account
  end
end

