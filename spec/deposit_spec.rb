require 'spec_helper'

describe PrintReleaf::Deposit do
  it_behaves_like "Resource"
  include_examples "Actions::Find"
  include_examples "Actions::List"
  include_examples "Actions::Create"
  include_examples "Actions::Delete"
end

describe PrintReleaf::Deposit, ".uri" do
  it "returns the base resource uri" do
    expect(PrintReleaf::Deposit.uri).to eq "/deposits"
  end
end

describe PrintReleaf::Deposit, "properties" do
  let(:json) do
    JSON.parse <<-JSON
      {
        "id": "a86d591c-3c29-4bef-82c3-7a007fb6b19c",
        "account_id": "971d10ac-a912-42c0-aa41-f55adc7b6755",
        "source_id": "44e182ed-cd50-4fa1-af90-e77dd6d6a78c",
        "date": "2016-07-05T12:29:12Z",
        "pages": 20000,
        "width": 0.2127,
        "height": 0.2762,
        "density": 216.0,
        "paper_type_id": "a11c7abc-011e-462f-babb-3c6375fa6473"
      }
    JSON
  end

  it "gives access to JSON properties" do
    deposit = PrintReleaf::Deposit.new(json)
    expect(deposit.id).to eq "a86d591c-3c29-4bef-82c3-7a007fb6b19c"
    expect(deposit.account_id).to eq "971d10ac-a912-42c0-aa41-f55adc7b6755"
    expect(deposit.source_id).to eq "44e182ed-cd50-4fa1-af90-e77dd6d6a78c"
    expect(deposit.date).to eq "2016-07-05T12:29:12Z"
    expect(deposit.pages).to eq 20000
    expect(deposit.width).to eq 0.2127
    expect(deposit.height).to eq 0.2762
    expect(deposit.density).to eq 216.0
    expect(deposit.paper_type_id).to eq "a11c7abc-011e-462f-babb-3c6375fa6473"
  end
end

describe PrintReleaf::Deposit, "#account" do
  it "returns the deposit's account" do
    account = double
    allow(PrintReleaf::Account).to receive(:find).with("123").and_return(account)
    deposit = PrintReleaf::Deposit.new(account_id: "123")
    expect(deposit.account).to eq account
  end
end

describe PrintReleaf::Deposit, "#source" do
  it "returns the deposit's source when it has one" do
    source = double
    allow(PrintReleaf::Source).to receive(:find).with("123").and_return(source)
    deposit = PrintReleaf::Deposit.new(source_id: "123")
    expect(deposit.source).to eq source
  end

  it "returns nil when it doesn't have a source" do
    deposit = PrintReleaf::Deposit.new
    expect(deposit.source).to eq nil
  end
end

describe PrintReleaf::Deposit, "#paper_type" do
  it "returns the deposit's paper_type when it has one" do
    paper_type = double
    allow(PrintReleaf::Paper::Type).to receive(:find).with("123").and_return(paper_type)
    deposit = PrintReleaf::Deposit.new(paper_type_id: "123")
    expect(deposit.paper_type).to eq paper_type
  end

  it "returns nil when it doesn't have a paper_type" do
    deposit = PrintReleaf::Deposit.new
    expect(deposit.paper_type).to eq nil
  end
end

