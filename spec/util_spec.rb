require 'spec_helper'

describe PrintReleaf::Util, ".join_uri" do
  it "returns a joined, normalized URI of all of the arguments" do
    result = PrintReleaf::Util.join_uri("/categories/123/", "/widgets/", "/456/")
    expect(result).to eq "/categories/123/widgets/456"
  end
end

