require 'spec_helper'

class Widget < PrintReleaf::Resource
  path "/widgets"
  action :find
  action :list
  action :create
  action :update
  action :delete
  action :activate
  action :deactivate
  property :id
  property :size
  property :quantity
  property :color
end

describe PrintReleaf::Actions::Find, ".find" do
  it "returns an instance of the resource for the given id" do
    json_data = double
    widget = double
    expect(PrintReleaf).to receive(:get).with("/widgets/123").and_return(json_data)
    expect(Widget).to receive(:new).with(json_data).and_return(widget)
    expect(Widget.find(123)).to eq widget
  end
end

describe PrintReleaf::Actions::List, ".list" do
  it "returns an array of instances of the resource" do
    json_data1, json_data2 = double, double
    widget1, widget2 = double, double
    expect(PrintReleaf).to receive(:get).with("/widgets", {offset: 10, limit: 5}).and_return([json_data1, json_data2])
    expect(Widget).to receive(:new).with(json_data1).and_return(widget1)
    expect(Widget).to receive(:new).with(json_data2).and_return(widget2)
    expect(Widget.list(offset: 10, limit: 5)).to eq [widget1, widget2]
  end
end

describe PrintReleaf::Actions::List do
  it "behaves like a collection" do
    widget1, widget2, widget3 = double(id: 1), double(id: 2), double(id: 3)
    allow(Widget).to receive(:list).and_return([widget1, widget2, widget3])
    expect(Widget.first).to eq widget1
    expect(Widget.last).to eq widget3
    expect(Widget.count).to eq 3
    expect(Widget.length).to eq 3
  end
end

describe PrintReleaf::Actions::Create, ".create" do
  it "creates, saves, and returns a new resource with the response data" do
    params = double
    json_data = double
    new_widget = double
    expect(PrintReleaf).to receive(:post).with("/widgets", params).and_return(json_data)
    expect(Widget).to receive(:new).with(json_data).and_return(new_widget)
    widget = Widget.create(params)
    expect(widget).to eq new_widget
  end
end

describe PrintReleaf::Actions::Update, "#save" do
  context "when the resource has an ID" do
    it "performs a patch with the resource's changed data, updates itself, and returns true" do
      response = double
      widget = Widget.new(id: 123, size: "Medium", quantity: 5)
      widget.size = "Large"
      expect(PrintReleaf).to receive(:patch).with("/widgets/123", {size: "Large"}).and_return(response)
      expect(widget).to receive(:reset).with(response)
      result = widget.save
      expect(result).to eq true
    end
  end

  context "when the resource does not have an ID" do
    it "performs a post with the resource's changed data, updates itself, and returns true" do
      response = double
      widget = Widget.new(size: "Medium", quantity: 5)
      widget.size = "Large"
      widget.color = "Blue"
      expect(PrintReleaf).to receive(:post).with("/widgets", {"size" => "Large", "quantity" => 5, "color" => "Blue"}).and_return(response)
      expect(widget).to receive(:reset).with(response)
      result = widget.save
      expect(result).to eq true
    end
  end
end

describe PrintReleaf::Actions::Delete, "#delete" do
  it "performs a delete on the resource, updates itself, and returns true" do
    response = double
    widget = Widget.new(id: 123)
    expect(PrintReleaf).to receive(:delete).with("/widgets/123").and_return(response)
    expect(widget).to receive(:reset).with(response)
    result = widget.delete
    expect(result).to eq true
  end
end

describe PrintReleaf::Actions::Activate, "#activate" do
  it "activates the resource and returns true" do
    response = double
    widget = Widget.new(id: 123)
    expect(PrintReleaf).to receive(:post).with("/widgets/123/activate").and_return(response)
    expect(widget).to receive(:reset).with(response)
    result = widget.activate
    expect(result).to eq true
  end
end

describe PrintReleaf::Actions::Deactivate, "#deactivate" do
  it "deactivates the resource and returns true" do
    response = double
    widget = Widget.new(id: 123)
    expect(PrintReleaf).to receive(:post).with("/widgets/123/deactivate").and_return(response)
    expect(widget).to receive(:reset).with(response)
    result = widget.deactivate
    expect(result).to eq true
  end
end

