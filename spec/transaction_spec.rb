require 'spec_helper'

describe PrintReleaf::Transaction do
  it_behaves_like "Resource"
  include_examples "Actions::Find"
  include_examples "Actions::List"
  include_examples "Actions::Create"
  include_examples "Actions::Delete"
end

describe PrintReleaf::Transaction, ".uri" do
  it "returns the base resource uri" do
    expect(PrintReleaf::Transaction.uri).to eq "/transactions"
  end
end

describe PrintReleaf::Transaction, "properties" do
  let(:json) do
    JSON.parse <<-JSON
      {
        "id": "70af5540-e3ec-4db7-bc45-4fb65b74368b",
        "account_id": "971d10ac-a912-42c0-aa41-f55adc7b6755",
        "quote_id": "83d12ee9-a187-489d-a93f-3096238f1f86",
        "project_id": "692bb68d-64aa-4a79-8a08-d373fb0d8752",
        "certificate_id": "70af5540-e3ec-4db7-bc45-4fb65b74368b",
        "date": "2015-10-22T01:52:12Z",
        "pages": 525377,
        "trees": 63.048
      }
    JSON
  end

  it "gives access to JSON properties" do
    transaction = PrintReleaf::Transaction.new(json)
    expect(transaction.id).to eq "70af5540-e3ec-4db7-bc45-4fb65b74368b"
    expect(transaction.account_id).to eq "971d10ac-a912-42c0-aa41-f55adc7b6755"
    expect(transaction.quote_id).to eq "83d12ee9-a187-489d-a93f-3096238f1f86"
    expect(transaction.project_id).to eq "692bb68d-64aa-4a79-8a08-d373fb0d8752"
    expect(transaction.certificate_id).to eq "70af5540-e3ec-4db7-bc45-4fb65b74368b"
    expect(transaction.date.to_date.to_s).to eq "2015-10-22"
    expect(transaction.pages).to eq 525377
    expect(transaction.trees).to eq 63.048
  end
end

describe PrintReleaf::Transaction, "#account" do
  it "returns the transaction's account" do
    account = double
    allow(PrintReleaf::Account).to receive(:find).with("123").and_return(account)
    transaction = PrintReleaf::Transaction.new(account_id: "123")
    expect(transaction.account).to eq account
  end
end

describe PrintReleaf::Transaction, "#project" do
  it "returns the transaction's project" do
    project = double
    allow(PrintReleaf::Forestry::Project).to receive(:find).with("123").and_return(project)
    transaction = PrintReleaf::Transaction.new(project_id: "123")
    expect(transaction.project).to eq project
  end
end

describe PrintReleaf::Transaction, "#certificate" do
  it "returns the transaction's certificate" do
    certificate = double
    allow(PrintReleaf::Certificate).to receive(:find).with("123").and_return(certificate)
    transaction = PrintReleaf::Transaction.new(certificate_id: "123")
    expect(transaction.certificate).to eq certificate
  end
end

describe PrintReleaf::Transaction, "#quote" do
  it "returns the transaction's quote" do
    quote = double
    allow(PrintReleaf::Quote).to receive(:find).with("123").and_return(quote)
    transaction = PrintReleaf::Transaction.new(quote_id: "123")
    expect(transaction.quote).to eq quote
  end

  it "returns nil when the transaction doesn't have a quote" do
    transaction = PrintReleaf::Transaction.new
    expect(transaction.quote).to eq nil
  end
end

