require 'spec_helper'

describe PrintReleaf::Relation do
  it "behaves like a collection" do
    owner = double
    resource_class = double(uri: "/resources")
    relation = PrintReleaf::Relation.new(owner, resource_class)

    book1 = double(title: "Book 1")
    book2 = double(title: "Book 2")

    allow(relation).to receive(:resources).and_return([book1, book2])

    expect(relation.size).to eql (2)
    expect(relation.length).to eql (2)
    expect(relation.count).to eql (2)

    titles = relation.map(&:title)
    expect(titles).to eql ["Book 1", "Book 2"]
  end

  it "includes the provided actions" do
    owner = double
    resource_class = double(uri: "/resources")
    relation = PrintReleaf::Relation.new(owner, resource_class, actions: [:list, :create])
    expect(relation).to respond_to :list
    expect(relation).to respond_to :create
  end
end

describe PrintReleaf::Relation, "#resources" do
  let(:author_class) do
    Class.new(PrintReleaf::Resource) do
      path '/authors'
      property :id
    end
  end

  let(:book_class) do
    Class.new(PrintReleaf::Resource) do
      path '/books'
    end
  end

  it "returns its list of resources" do
    author = author_class.new(id: 123)
    book1, book2 = double, double
    json_data1, json_data2 = double, double
    relation = PrintReleaf::Relation.new(author, book_class)
    expect(PrintReleaf).to receive(:get).with("/authors/123/books", {}).and_return([json_data1, json_data2])
    expect(book_class).to receive(:new).with(json_data1).and_return(book1)
    expect(book1).to receive(:owner=).with(author)
    expect(book_class).to receive(:new).with(json_data2).and_return(book2)
    expect(book2).to receive(:owner=).with(author)
    expect(relation.resources).to eq [book1, book2]
  end
end

