require 'spec_helper'

describe PrintReleaf::TransactionItem, "properties" do
  let(:json) do
    JSON.parse <<-JSON
      {
        "pages": 20000,
        "width": 0.2127,
        "height": 0.2762,
        "density": 216.0,
        "paper_type_id": "a11c7abc-011e-462f-babb-3c6375fa6473"
      }
    JSON
  end

  it "gives access to JSON properties" do
    item = PrintReleaf::TransactionItem.new(json)
    expect(item.pages).to eq 20000
    expect(item.width).to eq 0.2127
    expect(item.height).to eq 0.2762
    expect(item.density).to eq 216.0
    expect(item.paper_type_id).to eq "a11c7abc-011e-462f-babb-3c6375fa6473"
  end
end
