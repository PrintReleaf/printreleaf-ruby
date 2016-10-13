require 'spec_helper'

describe PrintReleaf::Resource, "#uri" do
  let(:widget_klass) do
    Class.new(PrintReleaf::Resource) do
      path "/widgets"
      property :id
    end
  end

  it "returns its class's uri joined with its id" do
    widget = widget_klass.new(id: 123)
    expect(widget.uri).to eql "/widgets/123"
  end
end

describe PrintReleaf::Resource, "#changes" do
  let(:widget_klass) do
    Class.new(PrintReleaf::Resource) do
      property :size
      property :color
      property :price
    end
  end

  it "returns a hash of the changed properties" do
    resource = widget_klass.new(size: "Large", color: "Blue", price: 123.45)
    resource.price = 678.90
    expect(resource.changes).to eq({"price" => 678.90})
    resource.size = "Medium"
    expect(resource.changes).to eq({"size" => "Medium", "price" => 678.90})
    resource.price = 123.45
    expect(resource.changes).to eq({"size" => "Medium"})
  end
end

