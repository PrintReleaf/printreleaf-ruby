RSpec.shared_examples "Resource" do
  it "inherits from Resource" do
    expect(described_class.ancestors).to include PrintReleaf::Resource
  end
end

RSpec.shared_examples "Actions::Find" do
  it "includes the Actions::Find module" do
    expect(described_class.ancestors).to include PrintReleaf::Actions::Find
  end
end

RSpec.shared_examples "Actions::List" do
  it "includes the Actions::List module" do
    expect(described_class.ancestors).to include PrintReleaf::Actions::List
  end
end

RSpec.shared_examples "Actions::Create" do
  it "includes the Actions::Create module" do
    expect(described_class.ancestors).to include PrintReleaf::Actions::Create
  end
end

RSpec.shared_examples "Actions::Update" do
  it "includes the Actions::Update module" do
    expect(described_class.ancestors).to include PrintReleaf::Actions::Update
  end
end

RSpec.shared_examples "Actions::Delete" do
  it "includes the Actions::Delete module" do
    expect(described_class.ancestors).to include PrintReleaf::Actions::Delete
  end
end

