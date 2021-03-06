require 'spec_helper'

describe PrintReleaf::Account do
  it_behaves_like "Resource"
  include_examples "Actions::Find"
  include_examples "Actions::List"
  include_examples "Actions::Create"
  include_examples "Actions::Update"
  include_examples "Actions::Activate"
  include_examples "Actions::Deactivate"
  include_examples "Actions::Delete"
end

describe PrintReleaf::Account, ".uri" do
  it "returns the base resource uri" do
    expect(PrintReleaf::Account.uri).to eq "/accounts"
  end
end

describe PrintReleaf::Account, ".mine" do
  it "returns an instance for the authenticated client's own account" do
    json_data = double
    account = double
    expect(PrintReleaf).to receive(:get).with("/account").and_return(json_data)
    expect(PrintReleaf::Account).to receive(:new).with(json_data).and_return(account)
    result = PrintReleaf::Account.mine
    expect(result).to eq account
  end
end

describe PrintReleaf::Account, "properties" do
  let(:json) do
    JSON.parse <<-JSON
      {
        "id": "971d10ac-a912-42c0-aa41-f55adc7b6755",
        "name": "Customer ABC",
        "display_name": "Customer ABC Display Name",
        "role": "customer",
        "created_at": "2014-10-13T02:55:29Z",
        "parent_id": "a2c031fa-6599-4939-8bc6-8128881953c4",
        "external_id": "Customer ABC External ID",
        "status": "active",
        "activated_at": "2014-10-13T02:55:29Z",
        "deactivated_at": null,
        "accounts_count": 0,
        "users_count": 3,
        "mtd_pages": 1234,
        "qtd_pages": 12345,
        "ytd_pages": 123456,
        "ltd_pages": 1234567,
        "mtd_trees": 0.15,
        "qtd_trees": 1.48,
        "ytd_trees": 14.82,
        "ltd_trees": 148.15
      }
    JSON
  end

  it "gives access to JSON properties" do
    account = PrintReleaf::Account.new(json)
    expect(account.id).to eq "971d10ac-a912-42c0-aa41-f55adc7b6755"
    expect(account.name).to eq "Customer ABC"
    expect(account.display_name).to eq "Customer ABC Display Name"
    expect(account.role).to eq "customer"
    expect(account.created_at).to eq DateTime.parse("2014-10-13T02:55:29Z")
    expect(account.parent_id).to eq "a2c031fa-6599-4939-8bc6-8128881953c4"
    expect(account.external_id).to eq "Customer ABC External ID"
    expect(account.status).to eq "active"
    expect(account.activated_at).to eq DateTime.parse("2014-10-13T02:55:29Z")
    expect(account.deactivated_at).to eq nil
    expect(account.accounts_count).to eq 0
    expect(account.users_count).to eq 3
    expect(account.mtd_pages).to eq 1234
    expect(account.qtd_pages).to eq 12345
    expect(account.ytd_pages).to eq 123456
    expect(account.ltd_pages).to eq 1234567
    expect(account.mtd_trees).to eq 0.15
    expect(account.qtd_trees).to eq 1.48
    expect(account.ytd_trees).to eq 14.82
    expect(account.ltd_trees).to eq 148.15
  end
end

describe PrintReleaf::Account, "#uri" do
  it "always returns its root uri" do
    account = PrintReleaf::Account.new(id: "123")
    expect(account.uri).to eq "/accounts/123"
    account.owner = double(uri: "/owner/123")
    expect(account.uri).to eq "/accounts/123"
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
    expect(account.parent).to eq parent
  end

  it "returns nil when its parent_id is nil" do
    account = PrintReleaf::Account.new(parent_id: nil)
    expect(account.parent).to eq nil
  end
end

describe PrintReleaf::Account, "#accounts" do
  it "returns a relation" do
    account = PrintReleaf::Account.new
    relation = double
    actions = [:find, :list, :create, :update, :activate, :deactivate]
    expect(PrintReleaf::Relation).to receive(:new).with(account, PrintReleaf::Account).and_return(relation)
    expect(account.accounts).to eq relation
  end
end

describe PrintReleaf::Account, "#certificates" do
  it "returns a relation" do
    account = PrintReleaf::Account.new
    relation = double
    allow(PrintReleaf::Relation).to receive(:new).with(account, PrintReleaf::Certificate).and_return(relation)
    expect(account.certificates).to eq relation
  end
end

describe PrintReleaf::Account, "#deposits" do
  it "returns a relation" do
    account = PrintReleaf::Account.new
    relation = double
    allow(PrintReleaf::Relation).to receive(:new).with(account, PrintReleaf::Deposit).and_return(relation)
    expect(account.deposits).to eq relation
  end
end

describe PrintReleaf::Account, "#feeds" do
  it "returns a relation" do
    account = PrintReleaf::Account.new
    relation = double
    allow(PrintReleaf::Relation).to receive(:new).with(account, PrintReleaf::Feed).and_return(relation)
    expect(account.feeds).to eq relation
  end
end

describe PrintReleaf::Account, "#invitations" do
  it "returns a relation" do
    account = PrintReleaf::Account.new
    relation = double
    allow(PrintReleaf::Relation).to receive(:new).with(account, PrintReleaf::Invitation).and_return(relation)
    expect(account.invitations).to eq relation
  end
end

describe PrintReleaf::Account, "#servers" do
  it "returns a relation" do
    account = PrintReleaf::Account.new
    relation = double
    allow(PrintReleaf::Relation).to receive(:new).with(account, PrintReleaf::Server).and_return(relation)
    expect(account.servers).to eq relation
  end
end

describe PrintReleaf::Account, "#transactions" do
  it "returns a relation" do
    account = PrintReleaf::Account.new
    relation = double
    allow(PrintReleaf::Relation).to receive(:new).with(account, PrintReleaf::Transaction).and_return(relation)
    expect(account.transactions).to eq relation
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
    allow(PrintReleaf::Relation).to receive(:new).with(account, PrintReleaf::VolumePeriod).and_return(relation)
    expect(account.volume).to eq relation
  end
end

