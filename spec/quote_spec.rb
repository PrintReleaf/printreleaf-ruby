require 'spec_helper'

describe PrintReleaf::Quote do
  it_behaves_like "Resource"
  include_examples "Actions::Find"
  include_examples "Actions::List"
  include_examples "Actions::Create"
  include_examples "Actions::Delete"
end

describe PrintReleaf::Quote, ".uri" do
  it "returns the base resource uri" do
    expect(PrintReleaf::Quote.uri).to eq "/quotes"
  end
end

describe PrintReleaf::Quote, "properties" do
  let(:json) do
    JSON.parse <<-JSON
      {
        "id": "83d12ee9-a187-489d-a93f-3096238f1f86",
        "account_id": "971d10ac-a912-42c0-aa41-f55adc7b6755",
        "created_at": "2015-10-22T00:37:11Z",
        "trees": 63.048,
        "standard_pages": 525377,
        "rate": 0.0003,
        "price": 157.61,
        "transaction_id": "70af5540-e3ec-4db7-bc45-4fb65b74368b",
        "items": [
          {
            "quantity": 20000,
            "width": 0.2127,
            "height": 0.2762,
            "density": 216.0,
            "paper_type_id": "a11c7abc-011e-462f-babb-3c6375fa6473"
          },
          {
            "quantity": 400000,
            "width": 0.2127,
            "height": 0.2762,
            "density": 89.0,
            "paper_type_id": "bbd0f271-2f9e-494c-b2af-7f9354b310ad"
          }
        ]
      }
    JSON
  end

  it "gives access to JSON properties" do
    quote = PrintReleaf::Quote.new(json)
    expect(quote.id).to eq "83d12ee9-a187-489d-a93f-3096238f1f86"
    expect(quote.account_id).to eq "971d10ac-a912-42c0-aa41-f55adc7b6755"
    expect(quote.created_at.to_date.to_s).to eq "2015-10-22"
    expect(quote.trees).to eq 63.048
    expect(quote.standard_pages).to eq 525377
    expect(quote.rate).to eq 0.0003
    expect(quote.price).to eq 157.61
    expect(quote.transaction_id).to eq "70af5540-e3ec-4db7-bc45-4fb65b74368b"
    expect(quote.items).to be_a Array
    expect(quote.items.length).to eq 2
    expect(quote.items[0]).to be_a PrintReleaf::QuoteItem
    expect(quote.items[1]).to be_a PrintReleaf::QuoteItem
  end
end

describe PrintReleaf::Quote, "#account" do
  it "returns the quote's account" do
    account = double
    allow(PrintReleaf::Account).to receive(:find).with("123").and_return(account)
    quote = PrintReleaf::Quote.new(account_id: "123")
    expect(quote.account).to eq account
  end
end

describe PrintReleaf::Quote, "#transaction" do
  it "returns the quote's transaction" do
    transaction = double
    allow(PrintReleaf::Transaction).to receive(:find).with("123").and_return(transaction)
    quote = PrintReleaf::Quote.new(transaction_id: "123")
    expect(quote.transaction).to eq transaction
  end

  it "returns nil when the quote has not yet been transacted" do
    quote = PrintReleaf::Quote.new
    expect(quote.transaction).to eq nil
  end
end


