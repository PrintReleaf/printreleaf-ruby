require 'spec_helper'

describe PrintReleaf::Account do
  it_behaves_like "Resource"
  include_examples "Actions::Find"
  include_examples "Actions::List"
  include_examples "Actions::Create"
  include_examples "Actions::Update"
  include_examples "Actions::Delete"
end

describe PrintReleaf::Account, ".uri" do
  it "returns the base resource uri" do
    expect(PrintReleaf::Account.uri).to eql "/accounts"
  end
end

describe PrintReleaf::Account, "properties" do
  let(:json) do
    JSON.parse <<-JSON
      {
        "id": "971d10ac-a912-42c0-aa41-f55adc7b6755",
        "name": "Customer ABC",
        "role": "customer",
        "created_at": "2014-10-13T02:55:29Z",
        "parent_id": "a2c031fa-6599-4939-8bc6-8128881953c4",
        "status": "active",
        "activated_at": "2014-10-13T02:55:29Z",
        "deactivated_at": null,
        "accounts_count": 0,
        "users_count": 3,
        "mtd_pages": 1234,
        "qtd_pages": 12345,
        "ytd_pages": 123456,
        "lifetime_pages": 1234567,
        "mtd_trees": 0.15,
        "qtd_trees": 1.48,
        "ytd_trees": 14.82,
        "lifetime_trees": 148.15
      }
    JSON
  end

  it "gives access to JSON properties" do
    account = PrintReleaf::Account.new(json)
    expect(account.id).to eq "971d10ac-a912-42c0-aa41-f55adc7b6755"
    expect(account.name).to eq "Customer ABC"
    expect(account.role).to eq "customer"
    expect(account.created_at).to eq DateTime.parse("2014-10-13T02:55:29Z")
    expect(account.parent_id).to eq "a2c031fa-6599-4939-8bc6-8128881953c4"
    expect(account.status).to eq "active"
    expect(account.activated_at).to eq DateTime.parse("2014-10-13T02:55:29Z")
    expect(account.deactivated_at).to eq nil
    expect(account.accounts_count).to eq 0
    expect(account.users_count).to eq 3
    expect(account.mtd_pages).to eq 1234
    expect(account.qtd_pages).to eq 12345
    expect(account.ytd_pages).to eq 123456
    expect(account.lifetime_pages).to eq 1234567
    expect(account.mtd_trees).to eq 0.15
    expect(account.qtd_trees).to eq 1.48
    expect(account.ytd_trees).to eq 14.82
    expect(account.lifetime_trees).to eq 148.15
  end
end

describe PrintReleaf::Account, "#activate" do
  it "activates the account and returns true" do
    account = PrintReleaf::Account.new(id: "123")
    response = double
    expect(PrintReleaf).to receive(:post).with("/accounts/123/activate").and_return(response)
    expect(account).to receive(:update).with(response)
    result = account.activate
    expect(result).to eq true
  end
end

describe PrintReleaf::Account, "#deactivate" do
  it "deactivates the account and returns true" do
    account = PrintReleaf::Account.new(id: "123")
    response = double
    expect(PrintReleaf).to receive(:post).with("/accounts/123/deactivate").and_return(response)
    expect(account).to receive(:update).with(response)
    result = account.deactivate
    expect(result).to eq true
  end
end

describe PrintReleaf::Account, "#parent" do
  it "returns the account's parent" do
    parent = double
    allow(PrintReleaf::Account).to receive(:find).with("123").and_return(parent)
    account = PrintReleaf::Account.new(parent_id: "123")
    expect(account.parent).to eql parent
  end
end

