require 'spec_helper'

describe PrintReleaf::Server do
  it_behaves_like "Resource"
  include_examples "Actions::Find"
  include_examples "Actions::List"
  include_examples "Actions::Create"
  include_examples "Actions::Update"
  include_examples "Actions::Delete"
end

describe PrintReleaf::Server, ".uri" do
  it "returns the base resource uri" do
    expect(PrintReleaf::Server.uri).to eq "/servers"
  end
end

describe PrintReleaf::Server, "properties" do
  let(:json) do
    JSON.parse <<-JSON
      {
        "id": "eadabb78-b199-43cb-adbd-ab36ce5c5a10",
        "account_id": "a2c031fa-6599-4939-8bc6-8128881953c4",
        "type": "fmaudit",
        "url": "https://myfmauditserver.com/",
        "username": "MyFMAuditUsername",
        "created_at": "2014-10-28T07:37:13Z"
      }
    JSON
  end

  it "gives access to JSON properties" do
    server = PrintReleaf::Server.new(json)
    expect(server.id).to eq "eadabb78-b199-43cb-adbd-ab36ce5c5a10"
    expect(server.account_id).to eq "a2c031fa-6599-4939-8bc6-8128881953c4"
    expect(server.type).to eq "fmaudit"
    expect(server.created_at).to eq DateTime.parse("2014-10-28T07:37:13Z")
    expect(server.url).to eq "https://myfmauditserver.com/"
    expect(server.username).to eq "MyFMAuditUsername"
    expect(server.password).to eq nil
  end
end

describe PrintReleaf::Server, "#account" do
  it "returns the server's account" do
    account = double
    allow(PrintReleaf::Account).to receive(:find).with("123").and_return(account)
    server = PrintReleaf::Server.new(account_id: "123")
    expect(server.account).to eq account
  end
end

