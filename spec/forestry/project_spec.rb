require 'spec_helper'

describe PrintReleaf::Forestry::Project do
  it_behaves_like "Resource"
  include_examples "Actions::Find"
  include_examples "Actions::List"
end

describe PrintReleaf::Forestry::Project, ".uri" do
  it "returns the base resource uri" do
    expect(PrintReleaf::Forestry::Project.uri).to eq "/forestry/projects"
  end
end

describe PrintReleaf::Forestry::Project, "properties" do
  let(:json) do
    JSON.parse <<-JSON
      {
        "id": "5d3b468f-c0a3-4e7c-bed4-2dcce9d3f0f9",
        "name": "Madagascar",
        "status": "active",
        "forest_latitude": -15.735844444444444,
        "forest_longitude": 46.35879166666667,
        "content_logo": "http://s3.amazonaws.com/projects/madagascar/logo.jpg",
        "content_masthead": "http://s3.amazonaws.com/projects/madagascar/masthead.jpg",
        "content_introduction": "Madagascar, due to its isolation from the rest of the world...",
        "content_body_html": "<h1>Madagascar is one of the most threatened ecosystems on the planet...",
        "content_images": [
          "http://s3.amazonaws.com/projects/madagascar/1.jpg",
          "http://s3.amazonaws.com/projects/madagascar/2.jpg",
          "http://s3.amazonaws.com/projects/madagascar/3.jpg"
        ]
      }
    JSON
  end

  it "gives access to JSON properties" do
    project = PrintReleaf::Forestry::Project.new(json)
    expect(project.id).to eq "5d3b468f-c0a3-4e7c-bed4-2dcce9d3f0f9"
    expect(project.name).to eq "Madagascar"
    expect(project.status).to eq "active"
    expect(project.forest_latitude).to eq -15.735844444444444
    expect(project.forest_longitude).to eq 46.35879166666667
    expect(project.content_logo).to eq "http://s3.amazonaws.com/projects/madagascar/logo.jpg"
    expect(project.content_masthead).to eq "http://s3.amazonaws.com/projects/madagascar/masthead.jpg"
    expect(project.content_introduction).to eq "Madagascar, due to its isolation from the rest of the world..."
    expect(project.content_body_html).to eq "<h1>Madagascar is one of the most threatened ecosystems on the planet..."
    expect(project.content_images).to eq [
      "http://s3.amazonaws.com/projects/madagascar/1.jpg",
      "http://s3.amazonaws.com/projects/madagascar/2.jpg",
      "http://s3.amazonaws.com/projects/madagascar/3.jpg"
    ]
  end
end

describe PrintReleaf::Forestry::Project, "#active?" do
  it "returns true when its status is 'active'" do
    project = PrintReleaf::Forestry::Project.new(status: 'active')
    expect(project.active?).to eq true
  end

  it "returns false when its status is not 'active'" do
    project = PrintReleaf::Forestry::Project.new(status: 'not active')
    expect(project.active?).to eq false
  end
end

describe PrintReleaf::Forestry::Project, "#inactive?" do
  it "returns true when its status is 'inactive'" do
    project = PrintReleaf::Forestry::Project.new(status: 'inactive')
    expect(project.inactive?).to eq true
  end

  it "returns false when its status is not 'inactive'" do
    project = PrintReleaf::Forestry::Project.new(status: 'not inactive')
    expect(project.inactive?).to eq false
  end
end
