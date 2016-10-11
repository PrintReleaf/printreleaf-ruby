require 'spec_helper'

describe PrintReleaf::Integration do
  it_behaves_like "Resource"
  include_examples "Actions::Retrieve"
  include_examples "Actions::List"
end

describe PrintReleaf::Integration, ".uri" do
  it "returns the base resource uri" do
    expect(PrintReleaf::Integration.uri).to eql "/integrations"
  end
end

describe PrintReleaf::Integration, "properties" do
  let(:json) do
    JSON.parse <<-JSON
      {
        "id": "98d3b1dc-25b2-4ff7-8328-b4815cc929d8",
        "name": "FMAudit",
        "description": "ECi FMAudit software for managed print services helps you streamline meter billing..."
      }
    JSON
  end

  it "gives access to JSON properties" do
    integration = PrintReleaf::Integration.new(json)
    expect(integration.id).to eq "98d3b1dc-25b2-4ff7-8328-b4815cc929d8"
    expect(integration.name).to eq "FMAudit"
    expect(integration.description).to eq "ECi FMAudit software for managed print services helps you streamline meter billing..."
  end
end

