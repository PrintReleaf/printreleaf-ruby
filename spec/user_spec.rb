require 'spec_helper'

describe PrintReleaf::User do
  it_behaves_like "Resource"
end

describe PrintReleaf::User, ".uri" do
  it "returns the base resource uri" do
    expect(PrintReleaf::User.uri).to eql "/users"
  end
end

describe PrintReleaf::User, "properties" do
  let(:json) do
    JSON.parse <<-JSON
      {
        "id": "5f25569f-ec0d-4ff3-a6ce-0456ac79b84d",
        "account_id": "415a588e-c6f6-46a8-a04f-96423f7e518d",
        "name": "David Example",
        "email": "david@example.com",
        "created_at": "2015-10-13T03:34:01Z"
      }
    JSON
  end

  it "gives access to JSON properties" do
    user = PrintReleaf::User.new(json)
    expect(user.id).to eq "5f25569f-ec0d-4ff3-a6ce-0456ac79b84d"
    expect(user.account_id).to eq "415a588e-c6f6-46a8-a04f-96423f7e518d"
    expect(user.name).to eq "David Example"
    expect(user.email).to eq "david@example.com"
    expect(user.created_at).to eq DateTime.parse("2015-10-13T03:34:01Z")
  end
end

describe PrintReleaf::User, "#account" do
  it "returns the user's account" do
    account = double
    allow(PrintReleaf::Account).to receive(:find).with("123").and_return(account)
    user = PrintReleaf::User.new(account_id: "123")
    expect(user.account).to eql account
  end
end

