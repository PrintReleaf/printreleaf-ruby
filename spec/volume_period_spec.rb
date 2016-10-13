require 'spec_helper'

describe PrintReleaf::VolumePeriod do
  it_behaves_like "Resource"
end

describe PrintReleaf::VolumePeriod, "properties" do
  let(:json) do
    JSON.parse <<-JSON
      {
        "account_id": "971d10ac-a912-42c0-aa41-f55adc7b6755",
        "date": "2016-08-01T06:00:00Z",
        "pages": 234567,
        "trees": 56.3
      }
    JSON
  end

  it "gives access to JSON properties" do
    volume_period = PrintReleaf::VolumePeriod.new(json)
    expect(volume_period.account_id).to eq "971d10ac-a912-42c0-aa41-f55adc7b6755"
    expect(volume_period.date).to eq DateTime.parse("2016-08-01T06:00:00Z")
    expect(volume_period.pages).to eq 234567
    expect(volume_period.trees).to eq 56.3
  end
end

describe PrintReleaf::VolumePeriod, "#account" do
  it "returns the volume period's account" do
    account = double
    allow(PrintReleaf::Account).to receive(:find).with("123").and_return(account)
    volume_period = PrintReleaf::VolumePeriod.new(account_id: "123")
    expect(volume_period.account).to eql account
  end
end

