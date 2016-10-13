require 'spec_helper'

describe PrintReleaf::Account do
  it_behaves_like "Resource"
  include_examples "Actions::Find"
  include_examples "Actions::List"
  include_examples "Actions::Create"
  include_examples "Actions::Update"
  include_examples "Actions::Delete"
  include_examples "Actions::Activate"
  include_examples "Actions::Deactivate"
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

describe PrintReleaf::Account, "#active?" do
  it "returns true when its status is 'active'" do
    account = PrintReleaf::Account.new(status: 'active')
    expect(account.active?).to eq true
  end

  it "returns false when its status is not 'active'" do
    account = PrintReleaf::Account.new(status: 'not active')
    expect(account.active?).to eq false
  end
end

describe PrintReleaf::Account, "#inactive?" do
  it "returns true when its status is 'inactive'" do
    account = PrintReleaf::Account.new(status: 'inactive')
    expect(account.inactive?).to eq true
  end

  it "returns false when its status is not 'inactive'" do
    account = PrintReleaf::Account.new(status: 'not inactive')
    expect(account.inactive?).to eq false
  end
end

describe PrintReleaf::Account, "#parent" do
  it "returns the account's parent account" do
    parent = double
    allow(PrintReleaf::Account).to receive(:find).with("123").and_return(parent)
    account = PrintReleaf::Account.new(parent_id: "123")
    expect(account.parent).to eql parent
  end
end

describe PrintReleaf::Account, "#activities" do
  it "returns a relation" do
    account = PrintReleaf::Account.new
    relation = double
    allow(PrintReleaf::Relation).to receive(:new).with(account, PrintReleaf::Activity).and_return(relation)
    expect(account.activities).to eq relation
  end
end

describe PrintReleaf::Account, "#invitations" do
  it "returns a relation" do
    account = PrintReleaf::Account.new
    relation = double
    allow(PrintReleaf::Relation).to receive(:new).with(account, PrintReleaf::Invitation, {actions: [:list, :find, :create, :delete]}).and_return(relation)
    expect(account.invitations).to eq relation
  end
end

describe PrintReleaf::Account, "#users" do
  it "returns a relation" do
    account = PrintReleaf::Account.new
    relation = double
    allow(PrintReleaf::Relation).to receive(:new).with(account, PrintReleaf::User).and_return(relation)
    expect(account.users).to eq relation
  end
end

describe PrintReleaf::Account, "#volume" do
  it "returns a relation" do
    account = PrintReleaf::Account.new
    relation = double
    allow(PrintReleaf::Relation).to receive(:new).with(account, PrintReleaf::VolumePeriod, {path: "/volume", actions: [:list]}).and_return(relation)
    expect(account.volume).to eq relation
  end
end

