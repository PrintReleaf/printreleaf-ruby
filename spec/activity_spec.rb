require 'spec_helper'

describe PrintReleaf::Activity do
  it_behaves_like "Resource"
end

describe PrintReleaf::Activity, "properties" do
  let(:json) do
    JSON.parse <<-JSON
      {
        "id": "8f3d2755-03ba-49db-8280-7dfc2902576f",
        "account_id": "971d10ac-a912-42c0-aa41-f55adc7b6755",
        "date": "2014-10-13T03:34:01Z",
        "type": "account.activated",
        "description": "Customer ABC's account was activated"
      }
    JSON
  end

  it "gives access to JSON properties" do
    activity = PrintReleaf::Activity.new(json)
    expect(activity.id).to eq "8f3d2755-03ba-49db-8280-7dfc2902576f"
    expect(activity.account_id).to eq "971d10ac-a912-42c0-aa41-f55adc7b6755"
    expect(activity.date).to eq DateTime.parse("2014-10-13T03:34:01Z")
    expect(activity.type).to eq "account.activated"
    expect(activity.description).to eq "Customer ABC's account was activated"
  end
end

describe PrintReleaf::Activity, "#account" do
  it "returns the activity's account" do
    account = double
    allow(PrintReleaf::Account).to receive(:find).with("123").and_return(account)
    activity = PrintReleaf::Activity.new(account_id: "123")
    expect(activity.account).to eql account
  end
end

