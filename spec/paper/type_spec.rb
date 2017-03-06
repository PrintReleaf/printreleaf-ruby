require 'spec_helper'

describe PrintReleaf::Paper::Type do
  it_behaves_like "Resource"
  include_examples "Actions::Find"
  include_examples "Actions::List"
  include_examples "Actions::Create"
  include_examples "Actions::Delete"
end

describe PrintReleaf::Paper::Type, ".uri" do
  it "returns the base resource uri" do
    expect(PrintReleaf::Paper::Type.uri).to eq "/paper/types"
  end
end

describe PrintReleaf::Paper::Type, "properties" do
  let(:json) do
    JSON.parse <<-JSON
      {
        "id": "d3c3e1df-5e55-4587-9d81-91ac87927424",
        "account_id": null,
        "name": "20# Bond/Writing/Ledger",
        "density": 74.0
      }
    JSON
  end

  it "gives access to JSON properties" do
    paper_type = PrintReleaf::Paper::Type.new(json)
    expect(paper_type.id).to eq "d3c3e1df-5e55-4587-9d81-91ac87927424"
    expect(paper_type.account_id).to eq nil
    expect(paper_type.name).to eq "20# Bond/Writing/Ledger"
    expect(paper_type.density).to eq 74.0
  end
end

describe PrintReleaf::Paper::Type, "#account" do
  it "returns the paper type's account" do
    account = double
    allow(PrintReleaf::Account).to receive(:find).with("123").and_return(account)
    paper_type = PrintReleaf::Paper::Type.new(account_id: "123")
    expect(paper_type.account).to eq account
  end

  it "returns nil when the paper type does not have an account_id" do
    paper_type = PrintReleaf::Paper::Type.new(account_id: nil)
    expect(paper_type.account).to eq nil
  end
end

