require 'spec_helper'

module PrintReleaf
  class Widget < Resource
    include Actions::Find
    include Actions::List
    include Actions::Create
    include Actions::Update
    include Actions::Delete

    property :id
    property :size
    property :quantity

    def self.uri
      "/widgets"
    end
  end
end

describe PrintReleaf::Actions::Find, ".find" do
  it "returns an instance of the resource for the given id" do
    json_data = double
    widget = double
    expect(PrintReleaf).to receive(:get).with("/widgets/123").and_return(json_data)
    expect(PrintReleaf::Widget).to receive(:new).with(json_data).and_return(widget)
    expect(PrintReleaf::Widget.find(123)).to eql widget
  end
end

describe PrintReleaf::Actions::List, ".list" do
  it "returns an array of instances of the resource" do
    json_data1, json_data2 = double, double
    widget1, widget2 = double, double
    expect(PrintReleaf).to receive(:get).with("/widgets", {offset: 10, limit: 5}).and_return([json_data1, json_data2])
    expect(PrintReleaf::Widget).to receive(:new).with(json_data1).and_return(widget1)
    expect(PrintReleaf::Widget).to receive(:new).with(json_data2).and_return(widget2)
    expect(PrintReleaf::Widget.list(offset: 10, limit: 5)).to eql [widget1, widget2]
  end
end

describe PrintReleaf::Actions::Create, ".create" do
  it "creates, saves, and returns a new resource with the response data" do
    params = double
    json_data = double
    new_widget = double
    expect(PrintReleaf).to receive(:post).with("/widgets", params).and_return(json_data)
    expect(PrintReleaf::Widget).to receive(:new).with(json_data).and_return(new_widget)
    widget = PrintReleaf::Widget.create(params)
    expect(widget).to eql new_widget
  end
end

describe PrintReleaf::Actions::Update, "#save" do
  it "performs a patch with the resource's changed data" do
    widget = PrintReleaf::Widget.new(id: 123, size: "Medium", quantity: 5)
    widget.size = "Large"
    expect(PrintReleaf).to receive(:patch).with("/widgets/123", {"size" => "Large"})
    widget.save
  end
end

describe PrintReleaf::Actions::Delete, "#delete" do
  it "performs a delete on the resource" do
    widget = PrintReleaf::Widget.new(id: 123)
    expect(PrintReleaf).to receive(:delete).with("/widgets/123")
    widget.delete
  end
end

