require 'spec_helper'

describe PrintReleaf::Source do
  it_behaves_like "Resource"
  include_examples "Actions::Find"
  include_examples "Actions::List"
  include_examples "Actions::Create"
  include_examples "Actions::Update"
  include_examples "Actions::Delete"
  include_examples "Actions::Activate"
  include_examples "Actions::Deactivate"
end

describe PrintReleaf::Source, ".uri" do
  it "returns the base resource uri" do
    expect(PrintReleaf::Source.uri).to eq "/sources"
  end
end

describe PrintReleaf::Source, "properties" do
  let(:json) do
    JSON.parse <<-JSON
      {
        "id": "44e182ed-cd50-4fa1-af90-e77dd6d6a78c",
        "account_id": "971d10ac-a912-42c0-aa41-f55adc7b6755",
        "type": "fmaudit",
        "server_id": "eadabb78-b199-43cb-adbd-ab36ce5c5a10",
        "external_id": "456",
        "collection_scope": "managed_only",
        "created_at": "2015-10-28T07:37:13Z",
        "status": "active",
        "activated_at": "2015-10-28T07:37:13Z",
        "deactivated_at": null,
        "health_check": "ok",
        "health_check_updated_at": "2016-10-28T07:37:13Z"
      }
    JSON
  end

  it "gives access to JSON properties" do
    source = PrintReleaf::Source.new(json)
    expect(source.id).to eq "44e182ed-cd50-4fa1-af90-e77dd6d6a78c"
    expect(source.account_id).to eq "971d10ac-a912-42c0-aa41-f55adc7b6755"
    expect(source.type).to eq "fmaudit"
    expect(source.server_id).to eq "eadabb78-b199-43cb-adbd-ab36ce5c5a10"
    expect(source.external_id).to eq "456"
    expect(source.collection_scope).to eq "managed_only"
    expect(source.created_at).to eq DateTime.parse("2015-10-28T07:37:13Z")
    expect(source.status).to eq "active"
    expect(source.activated_at).to eq DateTime.parse("2015-10-28T07:37:13Z")
    expect(source.deactivated_at).to eq nil
    expect(source.health_check).to eq "ok"
    expect(source.health_check_updated_at).to eq DateTime.parse("2016-10-28T07:37:13Z")
  end
end

describe PrintReleaf::Source, "#account" do
  it "returns the source's account" do
    account = double
    allow(PrintReleaf::Account).to receive(:find).with("123").and_return(account)
    source = PrintReleaf::Source.new(account_id: "123")
    expect(source.account).to eq account
  end
end

describe PrintReleaf::Source, "#server" do
  it "returns the source's server when it has one" do
    server = double
    allow(PrintReleaf::Server).to receive(:find).with("123").and_return(server)
    source = PrintReleaf::Source.new(server_id: "123")
    expect(source.server).to eq server
  end

  it "returns nil when it doesn't have a server" do
    source = PrintReleaf::Source.new
    expect(source.server).to eq nil
  end
end

