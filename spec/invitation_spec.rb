require 'spec_helper'

describe PrintReleaf::Invitation do
  it_behaves_like "Resource"
end

describe PrintReleaf::Invitation, ".uri" do
  it "returns the base resource uri" do
    expect(PrintReleaf::Invitation.uri).to eq "/invitations"
  end
end

describe PrintReleaf::Invitation, "properties" do
  let(:json) do
    JSON.parse <<-JSON
      {
        "id": "26370b1e-15a5-4449-b3b1-622e99003d3f",
        "account_id": "971d10ac-a912-42c0-aa41-f55adc7b6755",
        "email": "sally@example.com",
        "created_at": "2015-10-13T03:34:01Z"
      }
    JSON
  end

  it "gives access to JSON properties" do
    invitation = PrintReleaf::Invitation.new(json)
    expect(invitation.id).to eq "26370b1e-15a5-4449-b3b1-622e99003d3f"
    expect(invitation.account_id).to eq "971d10ac-a912-42c0-aa41-f55adc7b6755"
    expect(invitation.email).to eq "sally@example.com"
    expect(invitation.created_at).to eq DateTime.parse("2015-10-13T03:34:01Z")
  end
end

describe PrintReleaf::Invitation, "#account" do
  it "returns the invitation's account" do
    account = double
    allow(PrintReleaf::Account).to receive(:find).with("123").and_return(account)
    invitation = PrintReleaf::Invitation.new(account_id: "123")
    expect(invitation.account).to eq account
  end
end

