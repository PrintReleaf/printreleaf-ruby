require 'spec_helper'

describe PrintReleaf::Relation do
  it "behaves like a collection" do
    owner = double
    resource_class = double(uri: "/resources", actions: [:list])
    relation = PrintReleaf::Relation.new(owner, resource_class)
    expect(relation).to respond_to :list

    book1 = double(title: "Book 1")
    book2 = double(title: "Book 2")

    allow(relation).to receive(:list).and_return([book1, book2])

    expect(relation.first).to eq book1
    expect(relation.last).to eq book2
    expect(relation.length).to eq 2
    expect(relation.count).to eq 2

    titles = relation.map(&:title)
    expect(titles).to eq ["Book 1", "Book 2"]
  end

  it "includes the provided actions" do
    owner = double
    resource_class = double(uri: "/resources")
    relation = PrintReleaf::Relation.new(owner, resource_class, actions: [:list, :create])
    expect(relation).to respond_to :list
    expect(relation).to respond_to :create
  end
end

