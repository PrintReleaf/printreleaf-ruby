module PrintReleaf
  class Project < Resource
    include Actions::Retrieve
    include Actions::List

    property :id
    property :name
    property :status
    property :forest_latitude
    property :forest_longitude
    property :content_logo
    property :content_masthead
    property :content_introduction
    property :content_body_html
    property :content_images

    def self.uri
      "/projects"
    end
  end
end

