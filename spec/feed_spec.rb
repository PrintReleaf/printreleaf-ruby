require 'spec_helper'

describe PrintReleaf::Feed do
  it_behaves_like "Resource"
  include_examples "Actions::Find"
  include_examples "Actions::List"
  include_examples "Actions::Create"
  include_examples "Actions::Update"
  include_examples "Actions::Delete"
  include_examples "Actions::Activate"
  include_examples "Actions::Deactivate"
end

describe PrintReleaf::Feed, ".uri" do
  it "returns the base resource uri" do
    expect(PrintReleaf::Feed.uri).to eq "/feeds"
  end
end

describe PrintReleaf::Feed, "properties" do
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
        "health_check_checked_at": "2016-10-28T07:37:13Z",
        "health_check_changed_at": "2016-10-28T09:37:13Z"
      }
    JSON
  end

  it "gives access to JSON properties" do
    feed = PrintReleaf::Feed.new(json)
    expect(feed.id).to eq "44e182ed-cd50-4fa1-af90-e77dd6d6a78c"
    expect(feed.account_id).to eq "971d10ac-a912-42c0-aa41-f55adc7b6755"
    expect(feed.type).to eq "fmaudit"
    expect(feed.server_id).to eq "eadabb78-b199-43cb-adbd-ab36ce5c5a10"
    expect(feed.external_id).to eq "456"
    expect(feed.collection_scope).to eq "managed_only"
    expect(feed.created_at).to eq DateTime.parse("2015-10-28T07:37:13Z")
    expect(feed.status).to eq "active"
    expect(feed.activated_at).to eq DateTime.parse("2015-10-28T07:37:13Z")
    expect(feed.deactivated_at).to eq nil
    expect(feed.health_check).to eq "ok"
    expect(feed.health_check_checked_at).to eq DateTime.parse("2016-10-28T07:37:13Z")
    expect(feed.health_check_changed_at).to eq DateTime.parse("2016-10-28T09:37:13Z")
  end
end

describe PrintReleaf::Feed, "#account" do
  it "returns the feed's account" do
    account = double
    allow(PrintReleaf::Account).to receive(:find).with("123").and_return(account)
    feed = PrintReleaf::Feed.new(account_id: "123")
    expect(feed.account).to eq account
  end
end

describe PrintReleaf::Feed, "#server" do
  it "returns the feed's server when it has one" do
    server = double
    allow(PrintReleaf::Server).to receive(:find).with("123").and_return(server)
    feed = PrintReleaf::Feed.new(server_id: "123")
    expect(feed.server).to eq server
  end

  it "returns nil when it doesn't have a server" do
    feed = PrintReleaf::Feed.new
    expect(feed.server).to eq nil
  end
end

