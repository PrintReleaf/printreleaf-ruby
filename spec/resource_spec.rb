require 'spec_helper'

describe PrintReleaf::Resource, "#uri" do
  let(:widget_klass) do
    Class.new(PrintReleaf::Resource) do
      property :id

      def self.uri
        "/widgets"
      end
    end
  end

  it "returns its class's uri joined with its id" do
    widget = widget_klass.new(id: 123)
    expect(widget.uri).to eql "/widgets/123"
  end
end

describe PrintReleaf::Resource, "#changes" do
  it "returns a hash of the changed properties" do
    klass = Class.new(PrintReleaf::Resource) do
      property :size
      property :color
      property :price
    end
    resource = klass.new(size: "Large", color: "Blue", price: 123.45)
    resource.price = 678.90
    expect(resource.changes).to eql({"price" => 678.90})
    resource.size = "Medium"
    expect(resource.changes).to eql({"size" => "Medium", "price" => 678.90})
    resource.price = 123.45
    expect(resource.changes).to eql({"size" => "Medium"})
  end
end

